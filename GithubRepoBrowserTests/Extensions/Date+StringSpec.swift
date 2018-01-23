//
//  Date+StringSpec.swift
//  GithubRepoBrowserTests
//
//  Created by Vitor Kawai Sala on 11/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import GithubRepoBrowser

final class DateStringSpec: QuickSpec {
    override func spec() {
        var date: Date!
        
        beforeEach {
            date = Date(timeIntervalSince1970: 0)
        }
        
        afterEach {
            date = nil
        }
        
        context("Date") {
            it("should return correct date string") {
                let str = date.localizedString
                expect(str).to(equal("12/31/1969"))
            }
        }
    }
}
