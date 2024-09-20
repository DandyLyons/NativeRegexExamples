import Testing
@testable import NativeRegexExamples
import CustomDump

@Suite(.tags(.literals, .email))
struct EmailTests_Literal: RegexTestSuite {
  @Test(arguments: ["hello@email.com", "myemail@something.co.uk", "user@sub.example.com", "some.name@place.com", "user..name@example.com"])
  func wholeMatch(_ input: String) throws {
    let wholeMatchOptional = input.wholeMatch(of: RegexLiterals.email)
    let wholeMatch = try #require(wholeMatchOptional) // unwrap
    let output = String(wholeMatch.output) // convert Substring to String
    expectNoDifference(output, input)
  }
  
  @Test("NOT wholeMatch(of:)",
        arguments: ["@email.com", "myName@"]
  )
  func not_wholeMatch(_ input: String) throws {
    let not_wholeMatch = input.wholeMatch(of: RegexLiterals.email)
    #expect(
      not_wholeMatch == nil,
      "False positive match found: \(input) should not match \(not_wholeMatch)"
    )
  }
  
  @Test("replace(_ regex: with:)")
  func replace() {
    var text = """
hello@email.com some other text
some other text myemail@example.org
"""
    text.replace(RegexLiterals.email, with: "⬛︎⬛︎⬛︎")
    let expected = """
⬛︎⬛︎⬛︎ some other text
some other text ⬛︎⬛︎⬛︎
"""
    expectNoDifference(expected, text)
  }
  
  @Test(arguments: [String]())
  func falsePositives(_ input: String) {
    withKnownIssue("False positive match found: \(input)") {
      let not_wholeMatch = input.wholeMatch(of: RegexLiterals.email)
      #expect(not_wholeMatch == nil)
    }
  }
}

@Suite(.tags(.builderDSL, .email))
struct EmailTests_DSL: RegexTestSuite {
  @Test(arguments: ["hello@email.com", "myemail@something.co.uk", "user@sub.example.com", "some.name@place.com", "user..name@example.com"])
  func wholeMatch(_ input: String) throws {
    let wholeMatchOptional = input.wholeMatch(of: RegexBuilders.email)
    let wholeMatch = try #require(wholeMatchOptional) // unwrap
    let output = String(wholeMatch.output) // convert Substring to String
    expectNoDifference(output, input)
  }
  
  @Test("NOT wholeMatch(of:)",
        arguments: ["@email.com", "myName@"]
  )
  func not_wholeMatch(_ input: String) throws {
    let not_wholeMatch = input.wholeMatch(of: RegexBuilders.email)
    #expect(
      not_wholeMatch == nil,
      "False positive match found: \(input) should not match \(not_wholeMatch)"
    )
  }
  
  @Test("replace(_ regex: with:)")
  func replace() {
    var text = """
hello@email.com some other text
some other text myemail@example.org
"""
    text.replace(RegexBuilders.email, with: "⬛︎⬛︎⬛︎")
    let expected = """
⬛︎⬛︎⬛︎ some other text
some other text ⬛︎⬛︎⬛︎
"""
    expectNoDifference(expected, text)
  }
  
  @Test(arguments: [String]())
  func falsePositives(_ input: String) {
    withKnownIssue("False positive match found: \(input)") {
      let not_wholeMatch = input.wholeMatch(of: RegexBuilders.email)
      #expect(not_wholeMatch == nil)
    }
  }
}


