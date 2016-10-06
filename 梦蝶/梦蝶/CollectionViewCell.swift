//
//  CollectionViewCell.swift
//  梦蝶
//
//  Created by 叶俊中 on 16/9/16.
//  Copyright © 2016年 叶俊中. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    var imageview: UIImageView!
    var label1: UILabel!
    var label2: UILabel!
    
    override var bounds: CGRect{
        didSet{
            contentView.frame = bounds
            
            //self.reloadInputViews()
        }
    }
    func  updata() {
        self.imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.width))
        self.label1 = UILabel(frame: CGRect(x: 0, y: self.bounds.width, width: self.bounds.width, height: (self.bounds.height - self.bounds.width)/2))
        self.label2 = UILabel(frame: CGRect(x: 0, y: self.bounds.width + self.label1.bounds.height, width: self.bounds.width, height: (self.bounds.height - self.bounds.width)/2))
        self.label2.font = UIFont.systemFont(ofSize: 13)
        self.label2.textColor = UIColor.gray
        self.contentView.addSubview(self.imageview)
        self.contentView.addSubview(self.label1)
        self.contentView.addSubview(self.label2)
    }

}
