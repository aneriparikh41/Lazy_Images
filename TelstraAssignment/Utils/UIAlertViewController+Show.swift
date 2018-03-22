//
//  UIAlertViewController+Show.swift
//  TelstraAssignment
//
//  Created by Yash on 19/03/18.
//  Copyright © 2018 infosys. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    static func show(message: String, completion: Constants.Blocks.Completion? = nil ) {
        if Thread.isMainThread {
            UIAlertController.show(message, completion: completion)
        } else {
            DispatchQueue.main.async {
                UIAlertController.show(message, completion: completion)
            }
        }
    }
    
    fileprivate static func show(_ message: String, completion: Constants.Blocks.Completion? = nil) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
            if let completion = completion {
                completion(true)
            }
        }))
        ((UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController)?.present(alert, animated: true, completion: nil)
    }
}
