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
