# NativeRegexExamples
NativeRegexExamples is a place for the Swift community to: 
1. crowd-source `Regex` solutions that can be used in your projects
2. learn from each other and develop best practices
	- Provide cheat sheets
3. test Regexes for: 
	- matches: so we can assess their capabilities
	- non-matches: so we can eliminate false positives
	- replacing capabilities

## Basic Usage
```swift 
@RegexActor
func foo() {
  let ssnRegex = RegexLiterals.ssn
  let string = "111-11-1111"
  string.contains(ssnRegex) // true
  string.wholeMatch(of: ssnRegex)
  
  var text = """
one SSN -> 111-11-1111
222-22-2222 <- another SSN 
"""
  text.replace(ssnRegex, with: "___")
// text is now:
//  one SSN -> ___
//  ⬛︎⬛︎⬛︎ <- another SSN
}
```

Don't just use the library. Have a look at the source code so that you can learn from it. Each regex has a literal definition and a RegexBuilder definition. For example: 
```swift
public extension RegexLiterals {
  static let ssn = #/
  # Area number: Can't be 000-199 or 666
  (?!0{3})(?!6{3})[0-8]\d{2}
  -
  # Group number: Can't be 00
  (?!0{2})\d{2}
  -
  # Serial number: Can't be 0000
  (?!0{4})\d{4}
  /#
}

public extension RegexBuilders {
  static let ssn = Regex {
    NegativeLookahead {
      Repeat(count: 3) {
        "0"
      }
    }
    NegativeLookahead {
      Repeat(count: 3) {
        "6"
      }
    }
    ("0"..."8")
    Repeat(count: 2) {
      One(.digit)
    }
    "-"
    NegativeLookahead {
      Repeat(count: 2) {
        "0"
      }
    }
    Repeat(count: 2) {
      One(.digit)
    }
    "-"
    NegativeLookahead {
      Repeat(count: 4) {
        "0"
      }
    }
    Repeat(count: 4) {
      One(.digit)
    }
  }
  .anchorsMatchLineEndings()
}
```

## Motivation
Regular expressions are an extremely powerful tool capable of complex pattern matching, validation, parsing and so many more things. Nevertheless, it can be quite difficult to use, and it has a very esoteric syntax that is extremely easy to mess up. Every language has it's own "flavor" of Regex, and Swift's improves in some significant ways: 

1. Strict compile time type-checking
2. Syntax highlighting for Regex literals
3. An optional, more readable, DSL through RegexBuilder

However, many Swift resources about Regular expressions are about older technologies such as `NSRegularExpressions`, or third-party Swifty libraries. While these technologies and resources are great, they don't give us a chance to learn and unlock the new capabilities of native Swift Regex. 

Regex is also a decades-old technology. This means that many problems have long ago been solved in regular expressions. Better yet, Swift `Regex` literals are designed so that they are compatible with many other language flavors of regex including Perl, Python, Ruby, and Java. We might as well learn from the experiences of other communities!

## Contributing
Contributions are greatly appreciated for the benefit of the Swift community. Please feel free to file a PR or Issue!

All data types should have tests added. Testing is done entirely through the new [Swift Testing](https://developer.apple.com/xcode/swift-testing/) framework. This should ensure, that the library is usable/testable on non-Xcode, non-Apple platforms in the future.

Sorry, Swift Testing is Swift 6 and up only. Though, I see no reason why we shouldn't be able to backdeploy the library to 5.7 and up. 

### Recommended Resources
I strongly recommend using [swiftregex.com](https://swiftregex.com/) by [SwiftFiddle](https://github.com/SwiftFiddle). It's a powerful online playground for testing Swift `Regex`es. One of it's best features is that it can convert back and forth from traditional regex patterns and Swift's RegexBuilder DSL. 

## Inspirations
- [RegExLib.com](https://regexlib.com/Default.aspx) is one of many sites that crowd-sources regular expressions. It also, tests regular expressions for matches and non-matches
- [iHateRegex.com](https://ihateregex.io/playground) can visualize regular expression logic. 

## Gotchas
### Strict Concurrency Checking
The Swift `Regex` type is not `Sendable`. Apparently, this is because `Regex` allows users to hook in their own custom logic so Swift cannot guarantee data race safety. For this reason, I have made all the `Regex`es in the library isolated to `@RegexActor`, (a minimal global actor defined in the library). If I can find a better solution I will remove this actor isolation. If you use any regex from the library in your code directly, you will most likely need to isolate to `@RegexActor`. That being said, you should be able to copy and paste any regex in the library into your own code, and then you will no longer be limited to `@RegexActor`. 

## Recommended Resources

### Swift Regex
- [WWDC22 Meet Swift Regex](https://developer.apple.com/videos/play/wwdc2022/110357/)
- [WWDC22 Swift Regex: Beyond the basics](https://developer.apple.com/videos/play/wwdc2022/110358) 

### Swift Testing
- Video series: [Swift and Tips | Mastering Swift Testing series](https://www.youtube.com/watch?v=zXjM1cFUwW4&list=PLHWvYoDHvsOV67md_mU5nMN_HDZK7rEKn&pp=iAQB)
- [Mastering the Swift Testing Framework | Fatbobman's Blog](https://fatbobman.com/en/posts/mastering-the-swift-testing-framework/#parameterized-testing)
- I'm taking copious [notes](https://dandylyons.github.io/notes/Topics/Software-Development/Programming-Languages/Swift/testing-in-Swift/swift-testing) on `swift-testing` here. 

## Installation
Add NativeRegexExamples as a package dependency in your project's Package.swift:

```swift
// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "MyPackage",
    dependencies: [
        .package(
            url: "https://github.com/ladvoc/BijectiveDictionary.git",
            .upToNextMinor(from: "0.0.1")
        )
    ],
    targets: [
        .target(
            name: "MyTarget",
            dependencies: [
                .product(name: "NativeRegexExamples", package: "NativeRegexExamples")
            ]
        )
    ]
)
``` 

## Project Status
The project is in an early development phase. Current goals:

- [ ] **More examples with passing tests**: Increase examples to all common use cases of regular expressions
- [ ] **Documentation**: Ensure accuracy and completeness of documentation and include code examples.

Your contributions are very welcome! 

## License
This project is licensed under the MIT License. See the [LICENSE file](https://github.com/DandyLyons/NativeRegexExamples/blob/main/LICENSE) for details.
