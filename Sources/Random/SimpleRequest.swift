//
//  SimpleRequest.swift
//  Random
//
//  Created by xaoxuu on 2024/6/21.
//

import Foundation

enum SimpleRequestError: Error {
    case invalidURL
    case parseError
    case emptyResponse
}

struct SimpleResponse {
    let data: Data
    init(data: Data) {
        self.data = data
    }
    func mapDictionary() throws -> [AnyHashable: Any]? {
        try JSONSerialization.jsonObject(with: data) as? [AnyHashable: Any]
    }
    func mapString() -> String? {
        String(data: data, encoding: .utf8)
    }
}

struct SimpleRequest {
    
    static func request(_ url: String, method: String, headers: [String: String] = [:]) async -> Result<SimpleResponse, Error> {
        guard let url = URL(string: url) else {
            return .failure(SimpleRequestError.invalidURL)
        }
        var req = URLRequest(url: url)
        req.httpMethod = method
        headers.forEach { kv in
            req.setValue(kv.value, forHTTPHeaderField: kv.key)
        }
        return await withCheckedContinuation { cont in
            let task = URLSession.shared.dataTask(with: req) { data, resp, err in
                if let err {
                    cont.resume(returning: .failure(err))
                } else if let data {
                    cont.resume(returning: .success(.init(data: data)))
                } else {
                    cont.resume(returning: .failure(SimpleRequestError.emptyResponse))
                }
            }
            task.resume()
        }
    }
    
    static func get(_ url: String, headers: [String: String] = [:]) async -> Result<SimpleResponse, Error> {
         await request(url, method: "GET")
    }
    
}

typealias request = SimpleRequest
