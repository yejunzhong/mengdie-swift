//
//  MusiclistTableViewController.swift
//  梦蝶
//
//  Created by 叶俊中 on 16/9/16.
//  Copyright © 2016年 叶俊中. All rights reserved.
//

import UIKit
import Alamofire
class MusiclistTableViewController: UITableViewController {

    @IBOutlet var Tbview: UITableView!
    var background = UIImageView(image: UIImage(named:"background"))
    var flag = 0
    var name:String = ""
    var aduiotime = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        musicdetillist = [String]()
        musicaddresslist = [String]()
        musicduration = [String]()
        Tbview.delegate = self
        Tbview.dataSource = self
        Tbview.backgroundView = background
        //let a = "http://www.lizhi.fm/"+"\(data13)"
        Alamofire.request("http://www.lizhi.fm/"+"\(data13)").response { response in
            let a = String(data: response.data!,encoding:String.Encoding.utf8)
            //print(a)
            var c:String
            if let i = a?.range(of: "节目列表")?.upperBound{
                c = (a?.substring(from: i))!
                for _ in 1...20{
                    if let _ = c.range(of: "data-title=\"")?.upperBound{
                        let musicnamefromhtml = self.Stringcut(c, start: "data-title=\"", end: "\" data-duration")
                        let musicaddressfromhtml = self.Stringcut(c, start: "data-url=\"", end: "\" data-id")
                        let musicdurationfromhtml = self.Stringcut(c, start: "data-duration=\"", end: "\" data-url")
                        let musicaduiotimefromhtml = self.Stringcut(c, start: "aduioTime\">", end: "&nbsp;&nbsp;&nbsp")
                        let h = c.range(of: "&nbsp;&nbsp;&nbsp")
                        c = c.substring(from: (h?.upperBound)!)
                        musicdetillist.append(musicnamefromhtml)
                        musicaddresslist.append(musicaddressfromhtml)
                        musicduration.append(musicdurationfromhtml)
                        self.aduiotime.append(musicaduiotimefromhtml)
                        self.flag = 1
                        SVProgressHUD.dismiss()
                        self.navigationItem.rightBarButtonItem?.isEnabled = true
                    }else{
                        break
                    }
                }
                self.Tbview.reloadData()
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if flag == 0 {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
            SVProgressHUD.setDefaultMaskType(.none)
            SVProgressHUD.setDefaultStyle(.dark)
            SVProgressHUD.show(withStatus: "加载中")
        }
    }
    fileprivate func Stringcut(_ text:String,start:String,end:String) -> String {
        let startrange = text.range(of: start)?.upperBound
        let endstrange = text.range(of: end)?.lowerBound
        let textrange = Range<String.Index>(startrange!..<endstrange!)
        let cutstring = text.substring(with: textrange)
        return cutstring
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return musicdetillist.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = MusiclistTableViewCell()
        cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! MusiclistTableViewCell
        for a in cell.contentView.subviews {
            a.removeFromSuperview()
        }
        cell.updatacell(a:1)
        cell.musicnamelable.text = musicdetillist[(indexPath as NSIndexPath).section]
        cell.musicaduiotimelabel.text = aduiotime[(indexPath as NSIndexPath).section]
        let durationtimec = Int(musicduration[(indexPath as NSIndexPath).section])! % 60
        let durationtimem = (Int(musicduration[(indexPath as NSIndexPath).section])! - durationtimec) / 60
        cell.musicdurationlabel.text = "时长：\(durationtimem)'\(durationtimec)''"
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellnub = (indexPath as NSIndexPath).section
        performSegue(withIdentifier: "playersegue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "playersegue" {
            let des = segue.destination as! MusicPlayerController
            musicimage = UIImage(named: "Image-"+"\(tabInt)")!
            musictitle = musicnamelist[tabInt]//专辑名
            musicdetillisttag = musicdetillist//音乐名列表
            musicaddresslisttag = musicaddresslist//url列表
            musicdurationtag = musicduration//音乐持续时间
            musicaduiotime = self.aduiotime
            musicimagelist = [String].init(repeating: String(tabInt), count: musicdetillisttag.count)
            flag1 = 1
            des.musicitemnub = cellnub
            tabInttag = tabInt
        }
    }

}
