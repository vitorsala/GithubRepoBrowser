//
//  LocalizedStrings.swift
//  GithubRepoBrowser
//
//  Created by Vitor Kawai Sala on 24/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import Foundation

enum LocalizedStrings {
    enum Alert: String, Localizable {
        case ConnectionError = "alert.connection_error"
        case CodeWord = "alert.code_word"
    }
    
    enum GHTableView: String, Localizable {
        case BGNoData = "bginfo.nodata"
        case BGFetchFail = "bginfo.error"
    }
    
    enum PullRequestListTableViewCell: String, Localizable {
        case OpenInfo = "prlist.open_info"
    }
}
