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
    
    var refreshCtrl: UIRefreshControl!
    var cache:NSCache<AnyObject, AnyObject>!
    var task: URLSessionDownloadTask!
    var session: URLSession!
    
   
    
    let activityView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)

    override func viewDidLoad() {
        super.viewDidLoad()
        () = DataManager.sharedInstance.images.count > 0 ? () : fetch()
        tableView.estimatedRowHeight = 200.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        self.cache = NSCache()
        session = URLSession.shared
        task = URLSessionDownloadTask()
        
        pullToRefresh()
        }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        drawHeader()
        drawTable()
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

        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ImageTableViewCell {
            design(indexPath: indexPath, cell: cell)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

 extension ViewController {
    
    func fetch() {
        NetworkManager.shared.fetch(completion: { 
            print("Executed Successfully.\(DataManager.sharedInstance.images.count)")
            DispatchQueue.main.async(execute: { () -> Void in
                self.images = DataManager.sharedInstance.images
                self.tableView.reloadData()
                self.refreshCtrl?.endRefreshing()
            })
        }, error: { message in
            UIAlertController.show(message: message)
        })
   }
    func drawHeader() {
        //Header View
        headerView.frame = CGRect(x: 0, y: 20, width: self.view.frame.size.width, height: 40.0)
        let headerlabel = UILabel()
        headerlabel.text = Constants.Messages.title
        headerlabel.font = UIFont.preferredFont(forTextStyle: .headline)
        headerlabel.frame = CGRect(x: self.headerView.center.x - 50 , y: 10, width: self.headerView.frame.size.width, height: 20.0)
        headerView.addSubview(headerlabel)
        
        //Seperator
        let seperatorView = UIView()
        seperatorView.frame = CGRect(x: 0, y: 39, width: self.view.frame.size.width, height: 1)
        seperatorView.backgroundColor = UIColor.lightGray
        headerView.addSubview(seperatorView)
    }
    
    func drawTable() {
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
    func pullToRefresh() {
        self.refreshCtrl = UIRefreshControl()
        self.refreshCtrl.addTarget(self, action: #selector(ViewController.fetch), for: .valueChanged)
        self.tableView.refreshControl = self.refreshCtrl

    }
    
    func design(indexPath: IndexPath, cell: ImageTableViewCell) {
        cell.imageTitle.text = (images[indexPath.row].title == "" ? "No Data Found" : images[indexPath.row].title)
        cell.imageDesc.text = (images[indexPath.row].description == "" ? "No Data Found" : images[indexPath.row].description)
        
        activityView.center.x = 60
        activityView.center.y = cell.imageview.center.y
        cell.imageview.addSubview(activityView)
        activityView.startAnimating()
        cell.imageview.image = UIImage(named: "placeholder")
        
        if (cache.object(forKey: (indexPath as NSIndexPath).row as AnyObject) != nil){
            // Use cache
            print("Cached image used, no need to download it")
            activityView.stopAnimating()
            cell.imageview.image = cache.object(forKey: (indexPath as NSIndexPath).row as AnyObject) as? UIImage
        } else {
            let imageUrl = images[indexPath.row].imageURL
            if let url:URL = URL(string: imageUrl) {
                activityView.startAnimating()
                task = session.downloadTask(with: url, completionHandler: { (location, response, error) -> Void in
                    if let data = try? Data(contentsOf: url){
                        DispatchQueue.main.async(execute: { () -> Void in
                            // Before we assign the image, check whether the current cell is visible
                            if let updateCell = self.tableView.cellForRow(at: indexPath) as? ImageTableViewCell, let img:UIImage = UIImage(data: data) {
                                self.activityView.stopAnimating()
                                updateCell.imageview.image = img
                                self.cache.setObject(img, forKey: (indexPath as NSIndexPath).row as AnyObject)
                            }
                        })
                    }
                })
            } else {
                cell.imageview.image = UIImage(named: "placeholder")
                activityView.stopAnimating()
            }
            task?.resume()
        }
    }

}
