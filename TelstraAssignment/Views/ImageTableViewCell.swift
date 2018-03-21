//
//  ImageTableViewCell.swift
//  TelstraAssignment
//
//  Created by Yash on 21/03/18.
//  Copyright © 2018 infosys. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    let imageview = UIImageView()
    let imageTitle = UILabel()
    let imageDesc = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageTitle.translatesAutoresizingMaskIntoConstraints = false
        imageDesc.translatesAutoresizingMaskIntoConstraints = false
        
        imageview.backgroundColor = UIColor.blue
        imageDesc.numberOfLines = 0
        imageDesc.lineBreakMode = .byWordWrapping
        imageTitle.font = UIFont.preferredFont(forTextStyle: .headline)
        imageDesc.font = UIFont (name: "Helvetica Neue", size: 15)
        imageDesc.tintColor = UIColor.lightGray
        
        
        contentView.addSubview(imageview)
        contentView.addSubview(imageTitle)
        contentView.addSubview(imageDesc)
        
        let viewsDict = [
            "image" : imageview,
            "title" : imageTitle,
            "desc" : imageDesc
        ] as [String : Any]
        
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-11-[image(150)]-(>=11)-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-11-[title(20)]-[desc]-(>=10)-|", options: [.alignAllLeading], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[image(120)]-[title]-16-|", options: [.alignAllTop], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[image(120)]-[desc]-16-|", options: [], metrics: nil, views: viewsDict))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
