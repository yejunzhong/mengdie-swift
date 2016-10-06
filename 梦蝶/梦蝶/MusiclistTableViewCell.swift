//
//  MusiclistTableViewCell.swift
//  梦蝶
//
//  Created by 叶俊中 on 16/9/16.
//  Copyright © 2016年 叶俊中. All rights reserved.
//

import UIKit

class MusiclistTableViewCell: UITableViewCell {

    var playimage: UIImageView!
    var musicnamelable: UILabel!
    var musicaduiotimelabel: UILabel!//发布日期
    var musicdurationlabel: UILabel!//持续时间
    
    
    func updatacell(a:Int) {
        self.playimage = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        self.playimage.center = CGPoint(x: 22, y: bounds.midY)
        if a == 1{
            self.playimage.image = UIImage(named: "play")
        }else if a == 2{
            self.playimage.image = UIImage(named:"choice1")
        }
        self.contentView.addSubview(self.playimage)
        self.musicnamelable = UILabel(frame: CGRect(x: 42, y: 2, width: bounds.width - 42, height: 43))
        self.musicnamelable.lineBreakMode = .byWordWrapping
        self.musicnamelable.numberOfLines = 0
        self.contentView.addSubview(self.musicnamelable)
        self.musicaduiotimelabel = UILabel(frame: CGRect(x: 42,y: self.musicnamelable.frame.height + 4,width: 100,height: 15))
        self.musicaduiotimelabel.font = UIFont.systemFont(ofSize: 12)
        self.musicaduiotimelabel.textColor = UIColor.gray
        self.contentView.addSubview(self.musicaduiotimelabel)
        self.musicdurationlabel = UILabel(frame: CGRect(x: self.musicaduiotimelabel.frame.origin.x + 120,y: self.musicaduiotimelabel.frame.origin.y,width: bounds.width - self.musicaduiotimelabel.frame.origin.x + 100,height: 15))
        self.musicdurationlabel.font = UIFont.systemFont(ofSize: 12)
        self.musicdurationlabel.textColor = UIColor.gray
        self.contentView.addSubview(self.musicdurationlabel)
        
    }
    override var bounds: CGRect{
        didSet{
            contentView.frame = bounds
            //contentView.bounds.origin.x = 100
        }
    }
    

}
