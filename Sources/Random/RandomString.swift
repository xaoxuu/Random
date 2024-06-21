// The Swift Programming Language
// https://docs.swift.org/swift-book

/// 字符串类型
public enum RandomStringType {
    
    /// 诗词
    case poetry
    
    func generate() async -> String? {
        switch self {
        case .poetry:
            try? await RandomPoetry()?.content
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

