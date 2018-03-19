//
//  ViewController.swift
//  TelstraAssignment
//
//  Created by Yash on 19/03/18.
//  Copyright © 2018 infosys. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
    }

}

fileprivate extension ViewController {
    
    func fetch() {
        NetworkManager.shared.fetch(completion: { 
            print("Executed Successfully.\(DataManager.sharedInstance.images.count)")
        }, error: { message in
            UIAlertController.show(message: message)
        })

    }
}
