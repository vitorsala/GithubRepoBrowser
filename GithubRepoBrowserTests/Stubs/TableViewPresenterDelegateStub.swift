//
//  TableViewPresenterDelegateStub.swift
//  GithubRepoBrowserTests
//
//  Created by Vitor Kawai Sala on 10/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import UIKit

@testable import GithubRepoBrowser

final class TableViewPresenterDelegateStub: TableViewPresenterDelegate {
    
    var showStatusIndicatorTriggered = false
    var hideStatusIndicatorTriggered = false
    var reloadTableViewDataTriggered = false
    
    var performSegueTriggered = false
    var segueToBePerformed: SegueIdentifiers! = nil
    
    var showAlertTriggered = false
    var alertTitle: String! = nil
    var alertMessage: String! = nil
    
    func showStatusIndicator() {
        self.showStatusIndicatorTriggered = true
    }
    
    func hideStatusIndicator() {
        self.hideStatusIndicatorTriggered = true
    }
    
    func reloadTableViewData() {
        self.reloadTableViewDataTriggered = true
    }
    
    func perform(segue: SegueIdentifiers) {
        self.performSegueTriggered = true
        self.segueToBePerformed = segue
    }
    
    func showAlert(title: String, message: String) {
        self.showAlertTriggered = true
        self.alertTitle = title
        self.alertMessage = message
    }
}
