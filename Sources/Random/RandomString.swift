// The Swift Programming Language
// https://docs.swift.org/swift-book

/// API版本
public struct RandomAPIVersion: Equatable, ExpressibleByStringLiteral {
    public let rawValue: String
    public static let v1: RandomAPIVersion = .init(stringLiteral: "v1")
    public static let v2: RandomAPIVersion = .init(stringLiteral: "v2")
    public init(stringLiteral value: StringLiteralType) {
        self.rawValue = value
    }
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}

/// 字符串类型
public enum RandomStringType {
    
    /// 今日诗词
    case poetry(_ version: RandomAPIVersion)
    
    func generate() async -> String? {
        switch self {
        case .poetry(let version):
            if version == .v1 {
                return try? await RandomPoetryV1()?.content
            } else if version == .v2 {
                return try? await RandomPoetryV2()?.content
            } else {
                return nil
            }
        }
    }
    
}

public extension String {
    
    /// 生成随机字符串
    /// - Parameter type: 字符串类型
    /// - Returns: 随机字符串
    static func random(_ type: RandomStringType) async -> String? {
        await type.generate()
    }
    
}

