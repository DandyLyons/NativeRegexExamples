import RegexBuilder

public extension RegexLiterals {
  static let ipv4: Regex<Substring> = #/
  (?:\b25[0-5]|\b2[0-4][0-9]|\b[01]?[0-9][0-9]?)(?:\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)){3}
  /#
}


public extension RegexBuilders {
  static let ipv4 = Regex<Substring> {
    ChoiceOf {
      Regex {
        Anchor.wordBoundary
        "25"
        ("0"..."5")
      }
      Regex {
        Anchor.wordBoundary
        "2"
        ("0"..."4")
        ("0"..."9")
      }
      Regex {
        Anchor.wordBoundary
        Optionally(.anyOf("01"))
        ("0"..."9")
        Optionally(("0"..."9"))
      }
    }
    Repeat(count: 3) {
      Regex {
        "."
        ChoiceOf {
          Regex {
            "25"
            ("0"..."5")
          }
          Regex {
            "2"
            ("0"..."4")
            ("0"..."9")
          }
          Regex {
            Optionally(.anyOf("01"))
            ("0"..."9")
            Optionally(("0"..."9"))
          }
        }
      }
    }
  }
    .anchorsMatchLineEndings()
    
}
