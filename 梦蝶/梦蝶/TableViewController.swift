//
//  TableViewController.swift
//  梦蝶
//
//  Created by 叶俊中 on 16/9/16.
//  Copyright © 2016年 叶俊中. All rights reserved.
//

import UIKit

var timelabletext = "未开启"
class TableViewController: UITableViewController {
var alertcontroller = UIAlertController(title: "定时停止播放", message: nil, preferredStyle: .actionSheet)
    @IBOutlet weak var timelable: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let aler = ["10分钟","15分钟","30分钟","60分钟"]
        for i in 0...3 {
            alertcontroller.addAction(UIAlertAction(title: aler[i], style: .default,handler:{ (UIAlertAction) in
                //self.clockbutton.setBackgroundImage(UIImage(named:"redclock"), for: UIControlState())
                time0 = 0
                timeing = i
                self.timelable.text = timelabletext
                //print(timevalue!)
            } ))
        }
        alertcontroller.addAction(UIAlertAction(title: "当前节目播放完后", style: .default, handler: { (UIAlertAction) in
            //self.clockbutton.setBackgroundImage(UIImage(named:"redclock"), for: UIControlState())
            time0 = 0
            timeing = 4
            self.timelable.text = timelabletext
            //self.clocklabel.text = "单曲"
        }))
        alertcontroller.addAction(UIAlertAction(title: "关闭定时", style: .default, handler: { (UIAlertAction) in
            time0 = 0
            timevalue = nil
            timeing = -1
            self.timelable.text = timelabletext
            //self.clockbutton.setBackgroundImage(UIImage(named:"clock"), for: UIControlState())
            //self.clocklabel.text = ""
        }))
        alertcontroller.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        let color = UIColor(red: 53/255, green: 113/255, blue: 128/255, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = color
        self.navigationController?.navigationBar.tintColor = UIColor.white
        let titleAttrible = NSDictionary(object: UIColor.white, forKey: NSForegroundColorAttributeName as NSCopying)
        self.navigationController?.navigationBar.titleTextAttributes = titleAttrible as? [String : AnyObject]
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        timelable.text = timelabletext
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            if isplay {
                self.present(alertcontroller,animated:true,completion:nil)
            }
        }
        
    }

}
