@testable import NativeRegexExamples

/// A protocol used to ensure that each `@Suite` is testing for the same things.
///
/// `RegexTestSuite` also adds `@RegexActor` so that you don't need to add it to tests or suites.
@RegexActor
public protocol RegexTestSuite {
  /// Use this test to prove that the input string WILL whole match the input string.
  ///
  ///
  func wholeMatch(_ input: String) async throws
  /// Use this test to prove that the input string WILL NOT whole match the input string.
  func not_wholeMatch(_ input: String) async throws
  func replace() async
  func falsePositives(_ input: String) throws
}
