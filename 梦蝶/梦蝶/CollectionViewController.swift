//
//  CollectionViewController.swift
//  梦蝶
//
//  Created by 叶俊中 on 16/9/16.
//  Copyright © 2016年 叶俊中. All rights reserved.
//

import UIKit

//private let reuseIdentifier = "Cell"
class CollectionViewController: UICollectionViewController {

    @IBOutlet weak var cv: UICollectionView!
    var background = UIImageView(image: UIImage(named:"background"))
    override func viewDidLoad() {
        super.viewDidLoad()
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundView = background
        let color = UIColor(red: 53/255, green: 113/255, blue: 128/255, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = color
        self.navigationController?.navigationBar.tintColor = UIColor.white
        let titleAttrible = NSDictionary(object: UIColor.white, forKey: NSForegroundColorAttributeName as NSCopying)
        self.navigationController?.navigationBar.titleTextAttributes = titleAttrible as? [String : AnyObject]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = CollectionViewCell()
        cell = cv.dequeueReusableCell(withReuseIdentifier: "defaultCell", for: indexPath) as! CollectionViewCell
        for a in cell.contentView.subviews {
            a.removeFromSuperview()
        }
        cell.updata()
        cell.imageview.image = UIImage(named: "Image-"+"\((indexPath as NSIndexPath).row)")
        cell.label1.text = musicnamelist[(indexPath as NSIndexPath).row]
        cell.label2.text = musicuper[(indexPath as NSIndexPath).row]
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        data13 = musiclist1[(indexPath as NSIndexPath).row]
        tabInt = (indexPath as NSIndexPath).row
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize
    {
        let width = UIScreen.main.bounds.width / 2 - 25
        return CGSize(width: width, height: width + 60)
    }

}
