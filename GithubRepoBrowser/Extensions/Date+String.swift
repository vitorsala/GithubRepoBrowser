//
//  Date+String.swift
//  GithubRepoBrowser
//
//  Created by Vitor Kawai Sala on 10/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import Foundation

extension Date {
    var localizedString: String {
        let locale = Locale.current
        let template = "MM/dd/yyyy"
        
        let format = DateFormatter.dateFormat(fromTemplate: template, options: 0, locale: locale) ?? template
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
}
