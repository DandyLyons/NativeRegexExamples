import Foundation
import IssueReporting
import RegexBuilder

public extension RegexLiterals {
  /// A regex that identifies phone numbers.
  ///
  /// Have a look at the source code for this regex. It's a great example of Swift's extended delimiter literal
  /// syntax. In this syntaax, whitespace is ignored and comments can be added, meaning complex
  /// regex syntax can be used by split up in a way that is far more readable.
  static let phoneNumber = #/
  (?:\+\d{1,3}\s?)?   # Optional international code
  (?:\d{1,4}[-.\s]?)?  # Optional country or area code
  \d{1,4}[-.\s]?       # Area code or local part
  \d{1,4}[-.\s]?       # Local part or line number
  \d{1,4}             # Line number
  /#
}

public extension RegexBuilders {
  static let phoneNumber = Regex {
    Optionally {
      Regex {
        "+"
        Repeat(1...3) {
          One(.digit)
        }
        Optionally(.whitespace)
      }
    }
    Optionally {
      Regex {
        Repeat(1...4) {
          One(.digit)
        }
        Optionally {
          CharacterClass(
            .anyOf("-."),
            .whitespace
          )
        }
      }
    }
    Repeat(1...4) {
      One(.digit)
    }
    Optionally {
      CharacterClass(
        .anyOf("-."),
        .whitespace
      )
    }
    Repeat(1...4) {
      One(.digit)
    }
    Optionally {
      CharacterClass(
        .anyOf("-."),
        .whitespace
      )
    }
    Repeat(1...4) {
      One(.digit)
    }
  }
    .anchorsMatchLineEndings()

}


// MARK: PhoneNumberDataDetector
/// Experimental detector of phone numbers backed by `NSDataDetector`.
///
/// This is experimental and not yet ready for production use.
/// The phone number validation method used by `NSDataDetector` does not appear to 
/// have follow a documented standard such as E.164, NANP, or ITU-T E.212.
/// As such, we can't predict what the output will look like. Apple does not 
/// publicly document the algorithm used for phone number detection, so it is 
/// not possible to deterministically predict what phone numbers will be matched. 
@_spi(Experimental)
public struct PhoneNumberDataDetector: CustomConsumingRegexComponent {
    public typealias RegexOutput = String
    public func consuming(
        _ input: String,
        startingAt index: String.Index,
        in bounds: Range<String.Index>
    ) throws -> (upperBound: String.Index, output: String)? {
        var result: (upperBound: String.Index, output: String)?
        
        let types: NSTextCheckingResult.CheckingType = [.phoneNumber]
        let detector = try NSDataDetector(types: types.rawValue)
        let swiftRange = index..<input.endIndex
        let nsRange = NSRange(swiftRange, in: input)
        detector.enumerateMatches(
            in: input,
            options: [],
            range: nsRange,
            using: { (match, flags, _) in
                guard let phoneNumber = match?.phoneNumber,
                      let nsRange = match?.range,
                      let swiftRange = Range.init(nsRange, in: input) else {
                    // no phone number found
                    result = nil; return
                }
                
                result = (upperBound: swiftRange.upperBound, output: phoneNumber)
            }
        )
        
        return result
    }
}

public extension RegexCustomParsers {
    @_spi(Experimental)
    static let phoneNumberDataDetector = Regex {
        ChoiceOf {
            Anchor.startOfLine
            Anchor.startOfSubject
            One(.whitespace)
        }
        PhoneNumberDataDetector()
        ChoiceOf {
            Anchor.endOfLine
            Anchor.endOfSubject
            Anchor.endOfSubjectBeforeNewline
            One(.whitespace)
        }
    }
}

// MARK: PhoneNumberKit
public extension RegexCustomParsers {
    static let phoneNumberKit = Regex {
        Anchor.startOfSubject
        PhoneNumberKitCustomRegexComponent()
        Anchor.endOfSubject
    }
}

import PhoneNumberKit
/// A `RegexComponent` implemented using PhoneNumberKit
public struct PhoneNumberKitCustomRegexComponent: CustomConsumingRegexComponent {
    public typealias RegexOutput = String
    
    public init(
        region: String = PhoneNumberUtility.defaultRegionCode(),
        ignoreType: Bool = false
    ) {
        self.region = region
        self.ignoreType = ignoreType
    }
    
    /// ISO 3165 compliant code
    let region: String
    /// Avoids number type checking for faster performance
    let ignoreType: Bool
    
    public func consuming(
        _ input: String,
        startingAt index: String.Index,
        in bounds: Range<String.Index>
    ) throws -> (upperBound: String.Index, output: String)? {
        var result: (upperBound: String.Index, output: String)?
        
        let phoneNumberUtility = PhoneNumberUtility()
        let phoneNumber = try phoneNumberUtility.parse(
            input,
            withRegion: region,
            ignoreType: ignoreType
        )
        
        result = (upperBound: input.endIndex, output: phoneNumber.numberString)
        return result
    }
}
