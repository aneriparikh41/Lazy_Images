//
//  ViewController.swift
//  TelstraAssignment
//
//  Created by Yash on 19/03/18.
//  Copyright © 2018 infosys. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView = UITableView()
    var headerView: UIView = UIView()
    var images = DataManager.sharedInstance.images
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
        tableView.estimatedRowHeight = 200.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Header View
        headerView.frame = CGRect(x: 0, y: 20, width: self.view.frame.size.width, height: 40.0)
        let headerlabel = UILabel()
        headerlabel.text = "About Canada"//DataManager.sharedInstance.headerTitle
        headerlabel.font = UIFont.preferredFont(forTextStyle: .headline)
        headerlabel.frame = CGRect(x: self.headerView.center.x - 50 , y: 10, width: self.headerView.frame.size.width, height: 20.0)
        headerView.addSubview(headerlabel)
        
        let seperatorView = UIView()
        seperatorView.frame = CGRect(x: 0, y: 39, width: self.view.frame.size.width, height: 1)
        seperatorView.backgroundColor = UIColor.lightGray
        headerView.addSubview(seperatorView)
        
        //Table View
        let viewsDict = [
            "table" : tableView
            ] as [String : Any]
        tableView.frame = CGRect(x: 0, y: 60, width: self.view.frame.size.width, height: self.view.frame.size.height)
                tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        self.view.addSubview(tableView)
        self.view.addSubview(headerView)
        
      //  view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[table]-|", options: [], metrics: nil, views: viewsDict))
      //  view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[table]-|", options: [], metrics: nil, views: viewsDict))

    }
    
       
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if images.count > 0 {
            return images.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ImageTableViewCell
        cell.imageTitle.text = images[indexPath.row].title
        cell.imageDesc.text = images[indexPath.row].description
        cell.imageview.image = UIImage()
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

 extension ViewController {
    
    func fetch() {
        NetworkManager.shared.fetch(completion: { 
            print("Executed Successfully.\(DataManager.sharedInstance.images.count)")
            self.images = DataManager.sharedInstance.images
            self.tableView.reloadData()
        }, error: { message in
            UIAlertController.show(message: message)
        })
   }
    
     }
