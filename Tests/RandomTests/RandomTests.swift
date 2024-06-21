import XCTest
import Random
@testable import Random

final class RandomTests: XCTestCase {
    func testExample() async throws {
        // XCTest Documentation
        // https://developer.apple.com/documentation/xctest
        print("-- 创建RandomPoetry对象方式生成 --")
        if let str = try? await RandomPoetry()?.content {
            print(str)
        }
        print("-- 创建String对象方式生成 --")
        if let str: String = await .random(.poetry) {
            print(str)
        }
        // Defining Test Cases and Test Methods
        // https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods
    }
}
