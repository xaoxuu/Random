import XCTest
import Random
@testable import Random

final class RandomTests: XCTestCase {
    func testExample() async throws {
        // XCTest Documentation
        // https://developer.apple.com/documentation/xctest
        if let str = try? await RandomPoetryV1()?.content {
            print("创建RandomPoetry对象方式生成 v1: 「\(str)」")
        }
        if let str: String = await .random(.poetry(.v1)) {
            print("创建String对象方式生成 v1: 「\(str)」")
        }
        print("----")
        if let str = try? await RandomPoetryV2()?.content {
            print("创建RandomPoetry对象方式生成 v2: 「\(str)」")
        }
        if let str: String = await .random(.poetry(.v2)) {
            print("创建String对象方式生成 v2: 「\(str)」")
        }
        // Defining Test Cases and Test Methods
        // https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods
    }
}
