//
//  RandomPoetry.swift
//  Random
//
//  Created by xaoxuu on 2024/6/21.
//

import Foundation

fileprivate let tokenURL = "https://v2.jinrishici.com/token"
fileprivate let fetchURL = "https://v2.jinrishici.com/sentence"

/// 随机诗词
public struct RandomPoetryV2 {
    
    /// 诗词原文
    struct PoetryOrigin {
        
        /// 标题
        let title: String
        /// 朝代
        let dynasty: String
        /// 作者
        let author: String
        /// 内容
        let content: [String]
        
        init(rawValue: [AnyHashable: Any]?) {
            title = rawValue?["title"] as? String ?? ""
            dynasty = rawValue?["dynasty"] as? String ?? ""
            author = rawValue?["author"] as? String ?? ""
            content = rawValue?["content"] as? [String] ?? []
        }
    }
    
    let id: String?
    
    /// 摘要内容
    var content: String
    
    /// 原文
    let origin: PoetryOrigin?
    
    /// 随机创建一个诗词对象
    public init?() async throws {
        var token = UserDefaults.standard.string(forKey: tokenURL)
        if token == nil {
            token = try? await Self.genToken()
            UserDefaults.standard.set(token, forKey: tokenURL)
        }
        let ret = await request.get(fetchURL, headers: [
            "X-User-Token": token ?? ""
        ])
        switch ret {
        case .success(let resp):
            guard let dict = try? resp.mapDictionary() else {
                throw SimpleRequestError.parseError
            }
            guard let data = dict["data"] as? [AnyHashable: Any] else {
                throw SimpleRequestError.parseError
            }
            guard let content = data["content"] as? String else {
                throw SimpleRequestError.parseError
            }
            self.id = data["id"] as? String
            self.content = content
            let originDict = data["origin"] as? [AnyHashable: Any]
            self.origin = .init(rawValue: originDict)
        case .failure(let err):
            throw err
        }
    }
    
    static func genToken() async throws -> String {
        let result = await request.get(tokenURL)
        switch result {
        case .success(let resp):
            guard let dict = try? resp.mapDictionary() else {
                throw SimpleRequestError.parseError
            }
            return dict["data"] as? String ?? ""
        case .failure(let err):
            throw err
        }
    }
    
}
