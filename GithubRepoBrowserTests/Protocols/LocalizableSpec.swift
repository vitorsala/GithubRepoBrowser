//
//  LocalizableSpec.swift
//  GithubRepoBrowserTests
//
//  Created by Vitor Kawai Sala on 24/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import GithubRepoBrowser

private enum LocalizableStub: String, Localizable {
    case Test = "alert.code_word"
}

final class LocalizableSpec: QuickSpec {
    override func spec() {
        describe("protocol extension") {
            context("when used by an enum of strings") {
                it("should return an localized string") {
                    let str = LocalizableStub.Test.localizedString
                    expect(str).to(equal("Code"))
                }
            }
        }
    }
}
