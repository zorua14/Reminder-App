//
//  AlertManager.swift
//  Notification
//
//  Created by Karthikeyan Muthu on 23/10/23.
//

import Foundation
import UIKit
class AlertManager {
    static let shared = AlertManager()
    
    private init() { }
    
    func showAlert(from viewController: UIViewController, withTitle title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //If needed also get input for ok
        let okAction = UIAlertAction(title: "Ok", style: .default)
        
        alertController.addAction(okAction)
        
        viewController.present(alertController, animated: true, completion: nil)
    }
}
