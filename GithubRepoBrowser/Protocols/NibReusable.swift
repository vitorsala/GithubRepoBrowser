//
//  NibReusable.swift
//  GithubRepoBrowser
//
//  Created by Vitor Kawai Sala on 10/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import UIKit

protocol NibReusable {
    static var identifier: String { get }
    static var nib: UINib { get }
    static func loadFromNib() -> UITableViewCell
}

extension NibReusable {
    static var identifier: String {
        let className = String(describing: self)
        return className
    }
    
    static var nib: UINib {
        let className = String(describing: self)
        let nib = UINib(nibName: className, bundle: nil)
        return nib
    }
    
    static func loadFromNib() -> UITableViewCell {
        let className = String(describing: self)
        guard let cell = self.nib.instantiate(withOwner: nil, options: nil).first as? UITableViewCell else {
            fatalError("Fail to instantiate \(className) from Nib named \(className).xib, make sure that the xib name is the same as class's name")
        }
        return cell
    }
}
