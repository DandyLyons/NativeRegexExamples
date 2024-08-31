import RegexBuilder

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
  static let date_MM_DD_YYYY: Regex<(Substring, Substring, Substring, Substring)> = Regex {
    Anchor.wordBoundary
    Capture {
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
    }
    "/"
    Capture {
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
    }
    "/"
    Capture {
      Repeat(count: 4) {
        One(.digit)
      }
    }
    Anchor.wordBoundary
  }
  .anchorsMatchLineEndings()

}
