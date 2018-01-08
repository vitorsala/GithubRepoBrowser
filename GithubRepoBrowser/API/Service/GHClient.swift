//
//  GHClient.swift
//  GithubRepoBrowser
//
//  Created by Vitor Kawai Sala on 02/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import Foundation
import Alamofire

protocol GHClient {
    func fetch(request: GHRequest, callback: @escaping (GHResponse) -> Void)
}

enum GHClientError: Error {
    case invalidUrl(description: String)
    case genericError(description: String)
}

private final class FetchQueue {
    static let shared = FetchQueue()
    
    private let queue = OperationQueue()
    private init() {
        self.queue.maxConcurrentOperationCount = 1
    }
    
    func addOperation(_ block: @escaping () -> Void) {
        self.queue.addOperation(block)
    }
}

final class GHClientImpl: GHClient {
    private let queue = FetchQueue.shared
    private let sessionManager = SessionManager()
    
    private func method(for request: GHRequest) -> HTTPMethod {
        var method: HTTPMethod = .get
        switch request.method {
        case .get:
            method = .get
        case .post:
            method = .post
        }
        return method
    }
    
    func fetch(request: GHRequest, callback: @escaping (GHResponse) -> Void) {
        guard let url = URL(string: request.service.rawValue) else {
            callback(GHResponse(code: -1, data: nil, error: GHClientError.invalidUrl(description: "\(request.service.rawValue) is not an valid url")))
            return
        }
        
        self.queue.addOperation {
            self.sessionManager
                .request(url,
                         method: self.method(for: request),
                         parameters: request.parameters?.params,
                         encoding: URLEncoding.queryString,
                         headers: nil)
                .validate()
                .responseData(completionHandler: { (response) in
                    let resp = GHResponse(code: response.response?.statusCode ?? -1, data: response.result.value, error: response.error)
                    callback(resp)
                })
        }
    }
}
