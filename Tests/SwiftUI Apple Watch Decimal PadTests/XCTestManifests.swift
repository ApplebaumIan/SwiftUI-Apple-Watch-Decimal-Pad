import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SwiftUI_Apple_Watch_Decimal_PadTests.allTests),
    ]
}
#endif
