import CustomDump
@_spi(Experimental) import NativeRegexExamples
import Testing


// MARK: PhoneNumberKit
@Suite(.tags(.customParsers, .phoneNumber), .disabled())
struct PhoneNumberKitCustomRegexComponentTests: RegexTestSuite {
    @Test(arguments: ["(555) 555-1234", "555-1234", "5555-1234", "55-1234", "5551234", "1-555-1234"])
    func wholeMatch(_ input: String) throws {
        let wholeMatchOptional = input.wholeMatch(of: RegexCustomParsers.phoneNumberKit)
        guard let wholeMatch = wholeMatchOptional else {
            Issue.record("whole match for input: \(input) not found")
            return
        }
        let output = String(wholeMatch.output)
        expectNoDifference(output, input)
    }
    
    @Test("NOT wholeMatch(of:)",
          arguments: ["5555-1234", "555-12345", "55-1234", "5551234", "1-55-1234"]
    )
    func not_wholeMatch(_ input: String) throws {
        let not_wholeMatch = input.wholeMatch(of: RegexCustomParsers.phoneNumberDataDetector)
        withKnownIssue {
            Issue.record("input: \(input), not_wholeMatch: \(String(describingForTest: not_wholeMatch))")
            #expect(
                not_wholeMatch == nil,
                "False positive match found: \(input) should not match \(String(not_wholeMatch?.output ?? ""))"
            )
        }
    }
    
    @Test
    func replace() {
        var text = """
555-1234 some other text
some other text 555-1234
"""
        text.replace(RegexCustomParsers.phoneNumberDataDetector, with: "⬛︎⬛︎⬛︎")
        let expected = """
⬛︎⬛︎⬛︎ some other text
some other text ⬛︎⬛︎⬛︎
"""
        expectNoDifference(expected, text)
    }
  
  @Test(arguments: [String]())
  func falsePositives(_ input: String) {
    withKnownIssue("False positive match found: \(input)") {
      let not_wholeMatch = input.wholeMatch(of: RegexBuilders.phoneNumber)
      #expect(not_wholeMatch == nil)
    }
  }
}
