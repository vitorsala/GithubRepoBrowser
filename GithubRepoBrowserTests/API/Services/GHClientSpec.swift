//
//  GHClientSpec.swift
//  GithubRepoBrowserTests
//
//  Created by Vitor Kawai Sala on 02/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import GithubRepoBrowser

final class GHClientSpec: QuickSpec {
    override func spec() {
        var client: GHClient!
        
        beforeEach {
            client = GHClientRouter.apiClient
        }
        
        afterEach {
            client = nil
        }
        
        xdescribe("Client") {
            it("Should be able to adquire an valid response") {
                let request = GHRequest(method: .get, service: GHServiceEndpoint.root, parameters: nil)
                
                var response: GHResponse? = nil
                
                client.fetch(request: request, callback: { (testingResponse) in
                    response = testingResponse
                })
                
                expect(response).toEventuallyNot(beNil(), timeout: 5)
                expect(response?.data).toEventuallyNot(beNil())
                expect(response?.code).toEventually(equal(200))
            }
        }
    }
}
