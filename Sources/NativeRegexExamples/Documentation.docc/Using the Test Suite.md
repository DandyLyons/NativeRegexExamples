# Testing Suite
Test the effectiveness of your regular expressions. 


## What Are We Testing? 
When using regular expressions, we want to know what are the capabilities and limitations. In other words, we want to know **what is it that the Regex CAN do?** and **what is it that the Regex CANNOT do?** For this problem space, it is helpful to think in terms of the Confusion Matrix.

![Confusion Matrix](https://upload.wikimedia.org/wikipedia/commons/3/32/Binary_confusion_matrix.jpg)

For our purposes, "Actual" will refer to the actual string that is being assessed by the Regex, and "Predicted" refers to whether or not the Regex matched the the string. 

To illustrate, let's say we have a set of strings, and we want to determine if they are valid phone numbers. Some of these strings are **actually a phone number**. We'll call those "actual positives". Next, some of the strings, are not valid phone numbers. (They are **not actually a phone number**.) We'll call those "actual negatives".

Then each of these strings will be evaluated by a Regex. The Regex will match (or predict) if that string is a phone number. If it matches, then we can call that a "predicted positive" and if it does not match then we can call it a "predicted negative". But we of course need to be aware that the Regex could be accurate or inaccurate. This is where the Confusion Matrix comes in. 

If the Regex's prediction **matches actual** reality, then it is "true". If it **does not match actual** reality, then it is "false". We want to maximize "true" results and minimize "false" results. So we will design the tests so that they pass when the results are "true" and fail when the results are "false". 

## Reading the Tests
Reading the tests are quite simple, but they might behave slightly differently than other test suites that you are familiar with. Typically with a test suite, we simply want all of our tests to pass. Any test failure is bad, period.  

However, regular expressions are rarely perfect. There are certain "happy path" cases that they will match every time. And there are certain "edge cases" that they will fail at. The regular expression could fail in one of two ways, it could incorrectly label something a match (a "false positive"), or it could incorrectly label something as not matching (a "false negative"). Both of these cases are bad and covered by the test suite.

Since the results are "false" (meaning they are a "false positive" or a "false negative"), they should be marked in a way that shows that they are false. But we do not want a test failure. Instead we mark it as a known issue. 

## Adding Tests
To add a test, I recommend that you first look over some of the other tests. Each test should follow the same format to ensure readability and test coverage. 

### The Test Suite Struct
Each test should be in a struct which will act as the 

### RegexTestSuite protocol
The ``RegexTestSuite`` protocol serves a few purposes: 

1. It conveniently adds the ``RegexActor`` global actor. This means all of your tests will be concurrency-safe by default. 
2. It enforces that each test suite covers the same test methods, thus ensuring that the library has uniform test coverage. 

- Note: As good as this protocol is, it cannot guarantee perfect uniform test coverage. This is because the `Swift Testing` framework uses Swift macros, and currently Swift protocols do not have the ability to require macro usage. (If you have a better solution, please raise a PR. Also have a look at [Issue #1](https://github.com/DandyLyons/NativeRegexExamples/issues/1)). 

