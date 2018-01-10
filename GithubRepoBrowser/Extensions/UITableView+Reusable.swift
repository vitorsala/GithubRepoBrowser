//
//  UITableView+Reusable.swift
//  GithubRepoBrowser
//
//  Created by Vitor Kawai Sala on 10/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import UIKit

extension UITableView {
    func register(_ cell: NibReusable.Type) {
        let nib = cell.nib
        let identifier = cell.identifier
        self.register(nib, forCellReuseIdentifier: identifier)
    }
    
    func dequeueReusableCell<T: NibReusable>(_ cell: T.Type) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.identifier) as? T else {
            fatalError("\(T.identifier) was not found")
        }
        return cell
    }
}
