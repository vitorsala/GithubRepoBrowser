//
//  UIFont+GHIconsSpec.swift
//  GithubRepoBrowserTests
//
//  Created by Vitor Kawai Sala on 11/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import GithubRepoBrowser

final class UIFontGHIconsSpec: QuickSpec {
    override func spec() {
        context("UIFont") {
            it("Should return correct font") {
                let font = UIFont.GHIconFont(size: 20)
                expect(font.familyName).to(equal("octicons"))
                expect(font.pointSize).to(equal(20))
            }
        }
    }
}
