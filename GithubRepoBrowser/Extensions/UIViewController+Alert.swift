//
//  UIViewController+alert.swift
//  GithubRepoBrowser
//
//  Created by Vitor Kawai Sala on 10/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let closeAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (_) in
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(closeAction)
        self.present(alertController, animated: true)
    }
}
