//
//  GHClientUS.swift
//  GithubRepoBrowser
//
//  Created by Vitor Kawai Sala on 15/02/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import Foundation

final class GHClientUS {
    private let session: URLSession
    private var dataTask: URLSessionDataTask?
    
    init() {
        self.session = URLSession(configuration: .ephemeral)
    }
    
    private func buildQuery(params: GHParams) -> String {
        var query = ""
        var tail = false
        params.params.forEach {
            if tail {
                query.append("&")
            } else {
                tail = true
            }
            query.append("\($0.key)=\($0.value)")
        }
        return query
    }
}

extension GHClientUS: GHClient {
    
    func fetch(request: GHRequest, callback: @escaping (GHResponse) -> Void) {
        self.dataTask?.cancel()
        
        #if DEBUG
            print("fetching", request.service.string)
            if let params = request.parameters {
                print("with parameters", params.params)
            }
        #endif
        
        guard var urlComponents = URLComponents(string: request.service.string) else {
            return
        }
        if let parameters = request.parameters {
            let query = self.buildQuery(params: parameters)
            urlComponents.query = query
        }
        guard let url = urlComponents.url else { return }
        self.dataTask = self.session.dataTask(with: url) { data, response, error in
            defer { self.dataTask = nil }
            let code = (response as? HTTPURLResponse)?.statusCode ?? -1
            let ghResponse = GHResponse(code: code, data: data, error: error)
            DispatchQueue.main.async {
                callback(ghResponse)
            }
        }
        dataTask?.resume()
    }
}
