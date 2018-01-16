//
//  GHPullRequestListService.swift
//  GithubRepoBrowser
//
//  Created by Vitor Kawai Sala on 15/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import Foundation

final class GHPullRequestListService {
    private let client: GHClient
    
    init(client: GHClient = GHClientImpl()) {
        self.client = client
    }
    
    private func buildRequest(for repo: Repository) -> GHRequest {
        return GHRequest(method: .get,
                         service: GHServiceEndpoint.Repository.pullRequest(login: repo.owner.login, name: repo.name),
                         parameters: nil)
    }
    
    func fetchPullrequest(for repository: Repository, result: @escaping (Result<[PullRequest]>) -> Void) {
        
        let request = self.buildRequest(for: repository)
        
        self.client.fetch(request: request) { (response) in
            if let error = response.error {
                let res = Result<[PullRequest]>.error(response.code, error)
                result(res)
            } else if let data = response.data {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let repoList = try decoder.decode([PullRequest].self, from: data)
                    result(Result<[PullRequest]>.success(repoList))
                } catch let error {
                    result(Result<[PullRequest]>.error(-1, error))
                }
            }
        }
    }
}
