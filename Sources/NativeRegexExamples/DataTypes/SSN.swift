import RegexBuilder

public extension RegexLiterals {
  static let ssn = #/
  # Area number: Can't be 000-199 or 666
  (?!0{3})(?!6{3})[0-8]\d{2}
  -
  # Group number: Can't be 00
  (?!0{2})\d{2}
  -
  # Serial number: Can't be 0000
  (?!0{4})\d{4}
  /#
}

public extension RegexBuilders {
  static let ssn = Regex {
    NegativeLookahead {
      Repeat(count: 3) {
        "0"
      }
    }
    NegativeLookahead {
      Repeat(count: 3) {
        "6"
      }
    }
    ("0"..."8")
    Repeat(count: 2) {
      One(.digit)
    }
    "-"
    NegativeLookahead {
      Repeat(count: 2) {
        "0"
      }
    }
    Repeat(count: 2) {
      One(.digit)
    }
    "-"
    NegativeLookahead {
      Repeat(count: 4) {
        "0"
      }
    }
    Repeat(count: 4) {
      One(.digit)
    }
  }
  .anchorsMatchLineEndings()

}
