/// A namespace to hold `Regex`s defined using the literal syntax
@RegexActor
public enum RegexLiterals {}


/// A namespace to hold `Regex`s defined using the RegexBuilder syntax
@RegexActor
public enum RegexBuilders {}

/// A namespace to hold `Regex`s defined using a `CustomConsumingRegexComponent`.
/// 
/// Note: In my research it seems that `CustomConsumingRegexComponent` is not up 
/// to feature parity with `RegexComponent`. (This has not been confirmed.) See: https://github.com/DandyLyons/NativeRegexExamples/issues/3#issuecomment-2371688888
/// for updates on this.
@RegexActor
public enum RegexCustomParsers {}

