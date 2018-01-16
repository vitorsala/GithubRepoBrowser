//
//  GHClientStub.swift
//  GithubRepoBrowserTests
//
//  Created by Vitor Kawai Sala on 09/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import GithubRepoBrowser

final class GHClientStub: GHClient {
    var shouldReturnSuccess = true
    
    private func fileName(for service: GHService) -> String? {
        switch service {
        case GHServiceEndpoint.Search.repositories:
            return "RepositoryList01"
        case GHServiceEndpoint.Repository.pullRequest(_,_):
            return "RepositoryPRList"
        default:
            return nil
        }
    }
    
    private func file(named: String) -> Data? {
        guard let filePath = Bundle(for: GHClientStub.self).path(forResource: named, ofType: "json") else {
            return nil
        }
        
        let url = URL(fileURLWithPath: filePath)
        guard let data = try? Data(contentsOf: url, options: .uncached) else {
            return nil
        }
        
        return data
    }
    
    func fetch(request: GHRequest, callback: @escaping (GHResponse) -> Void) {
        guard self.shouldReturnSuccess == true else {
            let error = GHClientError.genericError(description: "Simulated Error")
            let response = GHResponse(code: 404, data: nil, error: error)
            callback(response)
            return
        }
        
        guard let fileName = self.fileName(for: request.service) else {
            let error = GHClientError.invalidUrl(description: "No local file for provided service")
            let response = GHResponse(code: -1, data: nil, error: error)
            callback(response)
            return
        }
        
        guard let fileData = self.file(named: fileName) else {
            let error = GHClientError.genericError(description: "Could not read file fron source")
            let response = GHResponse(code: -1, data: nil, error: error)
            callback(response)
            return
        }
        
        let response = GHResponse(code: 200, data: fileData, error: nil)
        callback(response)
    }
}
