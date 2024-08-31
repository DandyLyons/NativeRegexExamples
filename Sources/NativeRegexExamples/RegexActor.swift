/// A global actor for isolating `Regex`es
///
/// Unfortunately, `Regex` is not `Sendable` which means we must isolate our library `Regex`s.
@globalActor public actor  RegexActor: GlobalActor {
  public static let shared = RegexActor()
}

