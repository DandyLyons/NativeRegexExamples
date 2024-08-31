@testable import NativeRegexExamples

/// A protocol used to ensure that each `@TestSuite` is testing for the same things.
///
/// `RegexTestSuite` also adds `@RegexActor` so that you don't need to add it to tests or suites.
@RegexActor
protocol RegexTestSuite {
  func wholeMatch(_ input: String) async throws
  /// use this to prove that we are not matching false positives
  func not_wholeMatch(_ input: String) async throws
  func replace() async
}
