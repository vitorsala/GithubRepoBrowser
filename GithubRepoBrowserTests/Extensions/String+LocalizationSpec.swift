//
//  String+LocalizationSpec.swift
//  GithubRepoBrowserTests
//
//  Created by Vitor Kawai Sala on 24/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import GithubRepoBrowser

final class String_LocalizationSpec: QuickSpec {
    override func spec() {
        describe("Localized string") {
            it("should have an valid result") {
                let str = LocalizedStrings.Alert.CodeWord.localizedString
                expect(str).to(equal("Code"))
            }
            
            it("return the key if no string was found in table") {
                let str = "this.do.not.exist".localized
                expect(str).to(equal("**this.do.not.exist**"))
            }
        }
    }
}
