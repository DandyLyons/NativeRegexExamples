import Testing
@testable import NativeRegexExamples
import CustomDump
import Foundation

@Suite(.tags(.builderDSL, .date))
struct DateTests_MM_DD_YYYY_Literal: RegexTestSuite {
  @Test(arguments: ["01/01/1970"])
  func wholeMatch(_ input: String) throws {
    let wholeMatchOptional = input.wholeMatch(of: RegexBuilders.date_MM_DD_YYYY)
    guard let wholeMatch = wholeMatchOptional else {
      Issue.record(); return
    }
    let output = String(wholeMatch.output) // convert Substring to String
    expectNoDifference(output, input)
  }
  
  @Test("NOT wholeMatch(of:)",
        arguments: ["June 29, 2007", "12/32/2024", "1970-01-01"]
  )
  func not_wholeMatch(_ input: String) throws {
    let not_wholeMatch = input.wholeMatch(of: RegexBuilders.date_MM_DD_YYYY)
    #expect(
      not_wholeMatch == nil,
      "False positive match found: \(input) should not match \(not_wholeMatch)"
    )
  }
  
  @Test func knownIssues() {
    let falsePositives = ["02/29/2023", "04/31/2023"]
    for falsePositive in falsePositives {
      withKnownIssue {
        let not_wholeMatch = falsePositive.wholeMatch(of: RegexBuilders.date_MM_DD_YYYY)
        #expect(not_wholeMatch == nil)
      }
    }
  }
  
  @Test("replace(_ regex: with:)")
  func replace() {
    var text = """
06/29/2007 some other text
some other text 01/01/2000
"""
    text.replace(RegexBuilders.date_MM_DD_YYYY, with: "⬛︎⬛︎⬛︎")
    let expected = """
⬛︎⬛︎⬛︎ some other text
some other text ⬛︎⬛︎⬛︎
"""
    expectNoDifference(expected, text)
  }
}


@Suite(.tags(.builderDSL, .date))
struct DateTests_DSL: RegexTestSuite {
  @Test(arguments: ["01/01/1970"])
  func wholeMatch(_ input: String) throws {
    let wholeMatchOptional = input.wholeMatch(of: RegexBuilders.date)
    guard let wholeMatch = wholeMatchOptional else {
      Issue.record(); return
    }
    let date = Date(timeIntervalSince1970: 0)
    expectNoDifference(date, wholeMatch.output)
  }
  
  @Test("NOT wholeMatch(of:)",
        arguments: ["June 29, 2007", "02/29/2023", "12/32/2024", "1970-01-01"]
  )
  func not_wholeMatch(_ input: String) throws {
    let not_wholeMatch = input.wholeMatch(of: RegexBuilders.date)
    #expect(
      not_wholeMatch == nil,
      "False positive match found: \(input) should not match \(not_wholeMatch)"
    )
  }
  
  @Test("replace(_ regex: with:)")
  func replace() {
    var text = """
06/29/2007 some other text
some other text 01/01/2000
"""
    text.replace(RegexBuilders.date, with: "⬛︎⬛︎⬛︎")
    let expected = """
⬛︎⬛︎⬛︎ some other text
some other text ⬛︎⬛︎⬛︎
"""
    expectNoDifference(expected, text)
  }
}
