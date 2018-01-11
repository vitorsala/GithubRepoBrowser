//
//  NibReusable.swift
//  GithubRepoBrowser
//
//  Created by Vitor Kawai Sala on 10/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import UIKit

protocol NibLoadable: class {
    static var nib: UINib { get }
    static func loadFromNib() -> Self
}

extension NibLoadable {
    static var nib: UINib {
        let className = String(describing: self)
        let nib = UINib(nibName: className, bundle: Bundle(for: self))
        return nib
    }
    
    static func loadFromNib() -> Self {
        let className = String(describing: self)
        guard let view = self.nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError("Fail to instantiate \(className) from Nib named \(className).xib, make sure that the xib name is the same as class's name")
        }
        return view
    }
}

protocol NibReusable: NibLoadable {
    static var identifier: String { get }
}

extension NibReusable {
    static var identifier: String {
        let className = String(describing: self)
        return className
    }
}
