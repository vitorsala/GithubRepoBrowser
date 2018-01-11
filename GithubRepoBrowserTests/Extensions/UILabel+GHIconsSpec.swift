//
//  UILabel+GHIconsSpec.swift
//  GithubRepoBrowserTests
//
//  Created by Vitor Kawai Sala on 11/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import GithubRepoBrowser

final class UILabelGHIconsSpec: QuickSpec {
    override func spec() {
        var label: UILabel!
        
        beforeEach {
            label = UILabel()
        }
        
        afterEach {
            label = nil
        }
        
        context("Label") {
            it("Should have correct font and value") {
                label.setIcon(icon: GHIcons.exclamationMark, size: 18)
                expect(label.font.fontName).to(equal("octicons"))
                expect(label.font.pointSize).to(equal(18))
                expect(label.text).to(equal(GHIcons.exclamationMark.rawValue))
            }
        }
    }
}
