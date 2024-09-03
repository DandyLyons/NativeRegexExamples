import RegexBuilder
import Foundation

public extension RegexLiterals {
  /// A Regex literal which parses dates in the MM/DD/YYYY format.
  ///
  /// This regex is provided for learning purposes, but it is much better to use the regex parsers that ship in the
  /// Foundation library as they support a wide variety of formats and they account for locale.
  static let date_MM_DD_YYYY = #/\b(0[1-9]|1[0-2])/(0[1-9]|[12][0-9]|3[01])/(\d{4})\b/#
}

public extension RegexBuilders {
  /// A Regex literal which parses dates in the MM/DD/YYYY format.
  ///
  /// This regex is provided for learning purposes, but it is much better to use the regex parsers that ship in the
  /// Foundation library as they support a wide variety of formats and they account for locale.
  static let date_MM_DD_YYYY: Regex<(Substring)> = Regex {
    Anchor.wordBoundary
    ChoiceOf {
      Regex {
        "0"
        ("1"..."9")
      }
      Regex {
        "1"
        ("0"..."2")
      }
    }
    "/"
    ChoiceOf {
      Regex {
        "0"
        ("1"..."9")
      }
      Regex {
        One(.anyOf("12"))
        ("0"..."9")
      }
      Regex {
        "3"
        One(.anyOf("01"))
      }
    }
    "/"
    Repeat(count: 4) {
      One(.digit)
    }
    Anchor.wordBoundary
  }
  .anchorsMatchLineEndings()

//  /// An example of using one of Foundation's built in date parser.
//  ///
//  ///
//  static let iso8601: Regex<(Date)> = Regex {
//    One(
//      .iso8601(
//        timeZone: .gmt,
//        includingFractionalSeconds: false,
//        dateSeparator: .dash,
//        dateTimeSeparator: .standard,
//        timeSeparator: .omitted
//      )
//    )
//  }
  
  static let date = Regex {
    One(
      .dateTime(
        date: .numeric,
        time: .omitted,
        locale: .init(identifier: "en_US"),
        timeZone: .gmt
      )
    )
  }
}
