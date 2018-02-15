//
//  GHClientAF.swift
//  GithubRepoBrowser
//
//  Created by Vitor Kawai Sala on 15/02/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import Foundation
import Alamofire

final class GHClientAF: GHClient {
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
        #if DEBUG
            print("fetching", request.service.string)
            if let params = request.parameters {
                print("with parameters", params.params)
            }
        #endif
        
        self.sessionManager
            .request(request.service.url,
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
