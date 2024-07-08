//
//  File.swift
//  
//
//  Created by xaoxuu on 2024/7/8.
//

import Foundation

fileprivate let fetchURL = "https://v1.jinrishici.com/all.txt"

/// 随机诗词
public struct RandomPoetryV1 {
    
    var content = ""
    
    /// 随机创建一个诗词对象
    public init?() async throws {
        
        let ret = await request.get(fetchURL)
        switch ret {
        case .success(let resp):
            guard let str = resp.mapString() else {
                throw SimpleRequestError.parseError
            }
            content = str
        case .failure(let err):
            throw err
        }
    }
    
}
