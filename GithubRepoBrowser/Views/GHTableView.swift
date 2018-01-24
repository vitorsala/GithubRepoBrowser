//
//  GHTableView.swift
//  GithubRepoBrowser
//
//  Created by Vitor Kawai Sala on 22/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import UIKit

enum GHTableViewEvent {
    case Error
    case NoData
    case OK
}

private enum GHTableViewStrings {
    enum TableViewBackground {
        case NoData
        case FailedDataFetch
    }
}

extension GHTableViewStrings.TableViewBackground {
    var string: String {
        switch self {
        case .NoData:
            return LocalizedStrings.GHTableView.BGNoData.localizedString
        case .FailedDataFetch:
            return LocalizedStrings.GHTableView.BGFetchFail.localizedString
        }
    }
    var icon: GHIcons {
        switch self {
        case .NoData:
            return GHIcons.exclamationMark
        case .FailedDataFetch:
            return GHIcons.warningMark
        }
    }
}

final class GHTableView: UITableView {
    func setRefreshControl(target: Any, action: Selector){
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(target, action: action, for: UIControlEvents.valueChanged)
        self.refreshControl = refreshControl
    }
    
    func setBackgroundStyle(for event: GHTableViewEvent) {
        if event == .OK {
            self.separatorStyle = .singleLine
        } else {
            self.separatorStyle = .none
            self.backgroundView(for: event)
        }
    }
    
    func setDynamicRowSize() {
        self.rowHeight = UITableViewAutomaticDimension
        self.estimatedRowHeight = 80
    }
}

extension GHTableView {
    private func backgroundView(for event: GHTableViewEvent) {
        var view: TableViewBackgroundView?
        switch event {
        case .Error:
            view = TableViewBackgroundView.loadFromNib()
            view?.set(icon: GHTableViewStrings.TableViewBackground.FailedDataFetch.icon, text: GHTableViewStrings.TableViewBackground.FailedDataFetch.string)
        case .NoData:
            view = TableViewBackgroundView.loadFromNib()
            view?.set(icon: GHTableViewStrings.TableViewBackground.NoData.icon, text: GHTableViewStrings.TableViewBackground.NoData.string)
        default:
            view = nil
        }
        
        self.backgroundView = view
    
    }
}
