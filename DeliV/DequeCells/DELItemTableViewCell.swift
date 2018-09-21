//
//  DELItemTableViewCell.swift
//   DeliV
//
//  Created by Abilash Cumulations on 01/07/18.
//  Copyright © 2018 Cumulations Technologies. All rights reserved.
//

import UIKit
import SDWebImage


class DELItemTableViewCell: UITableViewCell {

    var itemImage: UIImageView!
    var itemDescription: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell()
    {
        let baseView = UIView(frame: CGRect(x: 10, y: 10, width: (UIApplication.shared.keyWindow?.frame.size.width)! - 20, height: 70))
        baseView.clipsToBounds  = false
        UIUtilities.addShadow(view: baseView)
        self.addSubview(baseView)
        //adding imageview
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: baseView.frame.size.height))
        baseView.addSubview(imageView)
        imageView.contentMode = .scaleToFill
        self.itemImage = imageView
        //adding description
        let label = UILabel(frame: CGRect(x: imageView.frame.size.width + 10, y: 5, width: baseView.frame.size.width - imageView.frame.size.width + 10, height: baseView.frame.size.height))
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        self.itemDescription = label
        baseView.addSubview(label)
    }

    func configureCell(item:Item,index:Int)
    {
        self.itemDescription.text = item.description
        if let url = URL(string: item.imageUrl)
        {
            self.itemImage.sd_setImage(with: url, placeholderImage: UIImage(named: "default"), options: SDWebImageOptions.forceTransition, completed: nil)
        }
        else{
            self.itemImage.image = UIImage(named: "default")
        }
        
        
    }
}
