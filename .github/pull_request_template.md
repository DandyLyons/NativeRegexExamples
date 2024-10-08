# Pull Request Template

## Description

Please include a summary of the change and which issue is fixed. Please also include relevant motivation and context. List any dependencies that are required for this change.

Fixes # (issue)

## Type of change

Please delete options that are not relevant.

- [ ] Bug fix (non-breaking change which fixes an issue)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] This change requires a documentation update

**Test Configuration**:
* Firmware version:
* Hardware:
* Toolchain:
* SDK:

## Checklist:
- [ ] I have performed a self-review of my own code
- [ ] I have commented my code, particularly in hard-to-understand areas
- [ ] I have made corresponding changes to the documentation
- [ ] My changes generate no new warnings
- [ ] If I have added a new `Regex`, have I: 
  - [ ] followed the same structure as the other `Regex` in the library. 
  - [ ] Added a literal version under the `RegexLiterals` namespace. 
  - [ ] Added a regex builder version under the `RegexBuilders` namespace. 
  - Note: I understand that it can be prohibitively time consuming and difficult to implement a Regex, let alone implement it in two very different syntaxes (literal and RegexBuilder). This is why I highly recommend copying and pasting your `Regex` into [swiftregex.com](https://www.swiftregex.com). It can immediately convert back and forth between both syntaxes. 
- [ ] I have added tests that prove my change is effective
  - [ ] If I have added a new `Regex`, then it is covered by a new test suite conforming to the `RegexTestSuite` protocol. 
  - [ ] I have added multiple test strings. (See other tests for examples.)
  - [ ] I have marked any failing tests with `withKnownIssues`
- [ ] New and existing unit tests pass locally with my changes
- [ ] Any dependent changes have been merged and published in downstream modules
- [ ] I have checked my code and corrected any misspellings