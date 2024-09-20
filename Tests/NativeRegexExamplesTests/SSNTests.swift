import Testing
@testable import NativeRegexExamples
import CustomDump

@Suite(.tags(.literals, .ssn))
struct SSNTests_Literal: RegexTestSuite {
  @Test(arguments: ["123-45-6789"])
  func wholeMatch(_ input: String) throws {
    let wholeMatchOptional = input.wholeMatch(of: RegexLiterals.ssn)
    let wholeMatch = try #require(wholeMatchOptional) // unwrap
    let output = String(wholeMatch.output) // convert Substring to String
    expectNoDifference(output, input)
  }
  
  @Test(
    "NOT wholeMatch(of:)",
    arguments: [
      "some other text", "", "-11-1111",
      "666-11-1111", "000-11-1111", "900-11-1111"
    ]
  )
  func not_wholeMatch(_ input: String) throws {
    let not_wholeMatch = input.wholeMatch(of: RegexLiterals.ssn)
    #expect(
      not_wholeMatch == nil,
      "False positive match found: \(input) should not match \(not_wholeMatch)"
    )
  }
  
  @Test("replace(_ regex: with:)")
  func replace() {
    var text = """
111-11-1111 some other text
some other text 222-22-2222
"""
    text.replace(RegexLiterals.ssn, with: "⬛︎⬛︎⬛︎")
    let expected = """
⬛︎⬛︎⬛︎ some other text
some other text ⬛︎⬛︎⬛︎
"""
    expectNoDifference(expected, text)
  }
  
  @Test(arguments: [String]())
  func falsePositives(_ input: String) {
    withKnownIssue("False positive match found: \(input)") {
      let not_wholeMatch = input.wholeMatch(of: RegexLiterals.ssn)
      #expect(not_wholeMatch == nil)
    }
  }
}

@Suite(.tags(.builderDSL, .ssn))
struct SSNTests_DSL: RegexTestSuite {
  @Test(arguments: ["123-45-6789"])
  func wholeMatch(_ input: String) throws {
    let wholeMatchOptional = input.wholeMatch(of: RegexBuilders.ssn)
    let wholeMatch = try #require(wholeMatchOptional) // unwrap
    let output = String(wholeMatch.output) // convert Substring to String
    expectNoDifference(output, input)
  }
  
  @Test(
    "NOT wholeMatch(of:)",
    arguments: [
      "some other text", "", "-11-1111",
      "666-11-1111", "000-11-1111", "900-11-1111"
    ]
  )
  func not_wholeMatch(_ input: String) throws {
    let not_wholeMatch = input.wholeMatch(of: RegexBuilders.ssn)
    #expect(
      not_wholeMatch == nil,
      "False positive match found: \(input) should not match \(not_wholeMatch)"
    )
  }
  
  @Test("replace(_ regex: with:)")
  func replace() {
    var text = """
111-11-1111 some other text
some other text 222-22-2222
"""
    text.replace(RegexBuilders.ssn, with: "⬛︎⬛︎⬛︎")
    let expected = """
⬛︎⬛︎⬛︎ some other text
some other text ⬛︎⬛︎⬛︎
"""
    expectNoDifference(expected, text)
  }
  
  @Test(arguments: [String]())
  func falsePositives(_ input: String) {
    withKnownIssue("False positive match found: \(input)") {
      let not_wholeMatch = input.wholeMatch(of: RegexBuilders.ssn)
      #expect(not_wholeMatch == nil)
    }
  }
}
