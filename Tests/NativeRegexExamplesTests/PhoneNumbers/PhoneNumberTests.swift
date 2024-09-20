import Testing
@testable import NativeRegexExamples
import CustomDump

extension Tag {
  // MARK: Regex Implementation Types
  /// A Regex component implemented using a Regex literals.
  @Tag static var literals: Self
  /// A Regex component implemented using the `RegexBuilder` DSL.
  @Tag static var builderDSL: Self
  /// A Regex component implemented using `CustomConsumingRegexComponent`.
  @Tag static var customParsers: Self

  // MARK: Data Types
  @Tag static var phoneNumber: Self
  @Tag static var email: Self
  @Tag static var date: Self
  @Tag static var ipv4: Self
  @Tag static var ssn: Self
}

@Suite(.tags(.literals, .phoneNumber))
struct Literals_PhoneNumberTests: RegexTestSuite {
  @Test(arguments: ["555-1234", "5551234", "1-555-1234"])
  func wholeMatch(_ input: String) throws {
    let wholeMatchOptional = input.wholeMatch(of: RegexLiterals.phoneNumber)
    let wholeMatch = try #require(wholeMatchOptional) // unwrap
    let output = String(wholeMatch.output) // convert Substring to String
    expectNoDifference(output, input)
  }
  
  @Test("NOT wholeMatch(of:)",
        arguments: ["5555-1234", "55-1234", "555-12345"]
  )
  func not_wholeMatch(_ input: String) throws {
    let not_wholeMatch = input.wholeMatch(of: RegexLiterals.phoneNumber)
    withKnownIssue {
      #expect(
        not_wholeMatch == nil,
        "False positive match found: \(input) should not match \(String(not_wholeMatch?.output ?? ""))"
      )
    }
  }
  
  @Test("NOT passing in a Regex through @Test")
  func replace() {
    var text = """
555-1234 some other text
some other text 1-555-1234
"""
    text.replace(RegexLiterals.phoneNumber, with: "⬛︎⬛︎⬛︎")
    let expected = """
⬛︎⬛︎⬛︎ some other text
some other text ⬛︎⬛︎⬛︎
"""
    expectNoDifference(expected, text)
  }
  
  @Test(arguments: [String]())
  func falsePositives(_ input: String) {
    withKnownIssue("False positive match found: \(input)") {
      let not_wholeMatch = input.wholeMatch(of: RegexBuilders.phoneNumber)
      #expect(not_wholeMatch == nil)
    }
  }
}

@Suite(.tags(.builderDSL, .phoneNumber))
struct Builder_PhoneNumberTests: RegexTestSuite {
  @Test(arguments: ["555-1234", "5551234", "1-555-1234"])
  func wholeMatch(_ input: String) throws {
    let wholeMatchOptional = input.wholeMatch(of: RegexBuilders.phoneNumber)
    let wholeMatch = try #require(wholeMatchOptional) // unwrap
    let output = String(wholeMatch.output) // convert Substring to String
    expectNoDifference(output, input)
  }
  
  @Test("NOT wholeMatch(of:)",
        arguments: ["5555-1234", "55-1234", "555-12345"]
  )
  func not_wholeMatch(_ input: String) throws {
    let not_wholeMatch = input.wholeMatch(of: RegexBuilders.phoneNumber)
    withKnownIssue {
      #expect(
        not_wholeMatch == nil,
        "False positive match found: \(input) should not match \(String(not_wholeMatch?.output ?? ""))"
      )
    }
  }
  
  @Test
  func replace() {
    var text = """
555-1234 some other text
some other text 1-555-1234
"""
    text.replace(RegexBuilders.phoneNumber, with: "⬛︎⬛︎⬛︎")
    let expected = """
⬛︎⬛︎⬛︎ some other text
some other text ⬛︎⬛︎⬛︎
"""
    expectNoDifference(expected, text)
  }
  
  
  @Test(arguments: [String]())
  func falsePositives(_ input: String) {
    withKnownIssue("False positive match found: \(input)") {
      let not_wholeMatch = input.wholeMatch(of: RegexBuilders.phoneNumber)
      #expect(not_wholeMatch == nil)
    }
  }
}


