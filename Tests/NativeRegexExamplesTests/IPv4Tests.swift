import Testing
@testable import NativeRegexExamples
import CustomDump

@Suite(.tags(.literals, .ipv4))
struct IPv4Tests_Literal: RegexTestSuite {
  @Test(arguments: [
    "127.0.0.1", "192.168.1.1", "0.0.0.0", "255.255.255.255", "1.2.3.4"
  ])
  func wholeMatch(_ input: String) throws {
    let wholeMatchOptional = input.wholeMatch(of: RegexLiterals.ipv4)
    let wholeMatch = try #require(wholeMatchOptional) // unwrap
    let output = String(wholeMatch.output) // convert Substring to String
    expectNoDifference(output, input)
  }
  
  @Test("NOT wholeMatch(of:)",
        arguments: ["256.256.256.256", "999.999.999.999", "1.2.3"]
  )
  func not_wholeMatch(_ input: String) throws {
    let not_wholeMatch = input.wholeMatch(of: RegexLiterals.ipv4)
    #expect(
      not_wholeMatch == nil,
      "False positive match found: \(input) should not match \(not_wholeMatch)"
    )
  }
  
  @Test("replace(_ regex: with:)")
  func replace() {
    var text = """
192.168.1.1 some other text
some other text 127.0.0.1
"""
    text.replace(RegexLiterals.ipv4, with: "⬛︎⬛︎⬛︎")
    let expected = """
⬛︎⬛︎⬛︎ some other text
some other text ⬛︎⬛︎⬛︎
"""
    expectNoDifference(expected, text)
  }
  
  @Test(arguments: [String]())
  func falsePositives(_ input: String) {
    withKnownIssue("False positive match found: \(input)") {
      let not_wholeMatch = input.wholeMatch(of: RegexLiterals.ipv4)
      #expect(not_wholeMatch == nil)
    }
  }
}

@Suite(.tags(.builderDSL, .ipv4))
struct IPv4Tests_DSL: RegexTestSuite {
  @Test(arguments: [
    "127.0.0.1", "192.168.1.1", "0.0.0.0", "255.255.255.255", "1.2.3.4"
  ])
  func wholeMatch(_ input: String) throws {
    let wholeMatchOptional = input.wholeMatch(of: RegexBuilders.ipv4)
    let wholeMatch = try #require(wholeMatchOptional) // unwrap
    let output = String(wholeMatch.output) // convert Substring to String
    expectNoDifference(output, input)
  }
  
  @Test("NOT wholeMatch(of:)",
        arguments: ["256.256.256.256", "999.999.999.999", "1.2.3"]
  )
  func not_wholeMatch(_ input: String) throws {
    let not_wholeMatch = input.wholeMatch(of: RegexBuilders.ipv4)
    #expect(
      not_wholeMatch == nil,
      "False positive match found: \(input) should not match \(not_wholeMatch)"
    )
  }
  
  @Test("replace(_ regex: with:)")
  func replace() {
    var text = """
192.168.1.1 some other text
some other text 127.0.0.1
"""
    text.replace(RegexBuilders.ipv4, with: "⬛︎⬛︎⬛︎")
    let expected = """
⬛︎⬛︎⬛︎ some other text
some other text ⬛︎⬛︎⬛︎
"""
    expectNoDifference(expected, text)
  }
  
  @Test(arguments: [String]())
  func falsePositives(_ input: String) {
    withKnownIssue("False positive match found: \(input)") {
      let not_wholeMatch = input.wholeMatch(of: RegexBuilders.ipv4)
      #expect(not_wholeMatch == nil)
    }
  }
}
