//
//  ViewControllerPresenter.swift
//  GithubRepoBrowser
//
//  Created by Vitor Kawai Sala on 10/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import UIKit

protocol TableViewPresenterDelegate: ViewControllerPresenterDelegate {
    func showStatusIndicator()
    func hideStatusIndicator()
    func reloadTableViewData()
}

protocol ViewControllerPresenterDelegate: class {
    func present(viewController: UIViewController)
    func showAlert(title: String, message: String)
}
