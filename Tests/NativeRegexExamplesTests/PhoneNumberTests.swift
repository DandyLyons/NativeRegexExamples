import Testing
@testable import NativeRegexExamples
import CustomDump

@Suite("Phone Numbers")
struct PhoneNumberTests: RegexTestSuite {
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
  
}
