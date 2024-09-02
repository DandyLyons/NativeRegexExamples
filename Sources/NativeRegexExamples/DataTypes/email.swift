import RegexBuilder

public extension RegexLiterals {
  static let email = /[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}/
}

public extension RegexBuilders {
  static let email = Regex {
    OneOrMore {
      CharacterClass(
        .anyOf("._%+-"),
        ("A"..."Z"),
        ("a"..."z"),
        ("0"..."9")
      )
    }
    "@"
    OneOrMore {
      CharacterClass(
        .anyOf(".-"),
        ("A"..."Z"),
        ("a"..."z"),
        ("0"..."9")
      )
    }
    "."
    Repeat(2...) {
      CharacterClass(
        ("A"..."Z"),
        ("a"..."z")
      )
    }
  }
  .anchorsMatchLineEndings()
}
