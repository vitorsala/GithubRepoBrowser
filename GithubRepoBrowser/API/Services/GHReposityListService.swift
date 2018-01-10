//
//  GHReposityListService.swift
//  GithubRepoBrowser
//
//  Created by Vitor Kawai Sala on 02/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import Foundation

final class GHReposityListService {
    private let client: GHClient
    
    init(client: GHClient = GHClientImpl()) {
        self.client = client
    }
    
    private func buildRequest(language: String?, sort: String?, page: Int?) -> GHRequest {
        
        var params: GHParams = GHParams()
        
        if let language = language {
            params.add(key: "q", value: "language:\(language)")
        }
        params.add(key: "sort", value: sort)
        params.add(key: "page", value: page)
        
        return GHRequest(method: .get,
                         service: GHService.repositoryList,
                         parameters: params)
    }
    
    func fetchRepositories(language: String = "Swift", sort: String = "stars", page: Int, result: @escaping (Result<RepositoryList>) -> Void) {
        
        let request = self.buildRequest(language: language, sort: sort, page: page)
        
        self.client.fetch(request: request) { (response) in
            if let error = response.error {
                let res = Result<RepositoryList>.error(response.code, error)
                result(res)
            } else if let data = response.data {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let repoList = try decoder.decode(RepositoryList.self, from: data)
                    result(Result<RepositoryList>.success(repoList))
                } catch let error {
                    result(Result<RepositoryList>.error(-1, error))
                }
            }
        }
    }
}
