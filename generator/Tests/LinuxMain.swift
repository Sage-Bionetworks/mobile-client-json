import XCTest

import generatorTests

var tests = [XCTestCaseEntry]()
tests += generatorTests.allTests()
XCTMain(tests)
