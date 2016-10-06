//
//  likeTableViewController.swift
//  梦蝶
//
//  Created by 叶俊中 on 16/9/17.
//  Copyright © 2016年 叶俊中. All rights reserved.
//

import UIKit
var likelist:[[String]]{
set(newvalue){
    defaults.set(newvalue, forKey: "like")
}
get{
    if let a = defaults.object(forKey: "like") as? [[String]]{
        return a
    }else{
        defaults.set(0, forKey: "like")
        return []
    }
}
}
class likeTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var allchoice: UIButton!
    @IBOutlet weak var donebutton: UIButton!
    @IBOutlet weak var set: UIBarButtonItem!
    let alertcontroller = UIAlertController(title: "温馨提示", message: "确定删除所选节目？", preferredStyle: .alert)
    var setflag = 1
    var deletelist = [[String]]()
    var background = UIImageView(image: UIImage(named:"background"))
    @IBAction func setbutton(_ sender: UIBarButtonItem) {
        if (self.tabBarController?.tabBar.isHidden)! {
            setflag = 1
            set.title = "编辑"
            self.tabBarController?.tabBar.isHidden = false
            
            self.table.reloadData()
        }else{
            setflag = 2
            set.title = "完成"
            self.tabBarController?.tabBar.isHidden = true
            self.table.reloadData()
        }
    }
    //@IBOutlet var tbview: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let a = self.tabBarController?.tabBar.frame.height
        table.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - a!)
        allchoice.frame = CGRect(x: 15, y: UIScreen.main.bounds.height - a!, width: 70, height: a!)
        allchoice.setTitle("全选", for: .normal)
        donebutton.frame = CGRect(x: UIScreen.main.bounds.width - 85, y: allchoice.frame.origin.y, width: 70, height: a!)
        donebutton.setTitle("删除", for: .normal)
        table.delegate = self
        table.dataSource = self
        table.backgroundView = background
        let color = UIColor(red: 53/255, green: 113/255, blue: 128/255, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = color
        self.navigationController?.navigationBar.tintColor = UIColor.white
        let titleAttrible = NSDictionary(object: UIColor.white, forKey: NSForegroundColorAttributeName as NSCopying)
        self.navigationController?.navigationBar.titleTextAttributes = titleAttrible as? [String : AnyObject]
        allchoice.addTarget(self, action: #selector(choiceall), for: .touchUpInside)
        donebutton.addTarget(self, action: #selector(done), for: .touchUpInside)
        //let alertcontroller = UIAlertController(title: "温馨提示", message: "确定删除所选节目？", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okaction = UIAlertAction(title: "确定", style: .default) { (action) in
            self.dodelete()
        }
        alertcontroller.addAction(cancelAction)
        alertcontroller.addAction(okaction)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.table.reloadData()
        deletelist = [[String]]()
        setflag = 1
        set.title = "编辑"
        self.tabBarController?.tabBar.isHidden = false
        self.table.reloadData()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return likelist.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = MusiclistTableViewCell()
        cell = tableView.dequeueReusableCell(withIdentifier: "likecell", for: indexPath) as! MusiclistTableViewCell
        for a in cell.contentView.subviews {
            a.removeFromSuperview()
        }
        cell.updatacell(a: setflag)
        cell.musicnamelable.text = likelist.reversed()[(indexPath as NSIndexPath).section][2]
        cell.musicaduiotimelabel.text = likelist.reversed()[(indexPath as NSIndexPath).section][5]
        let durationtimec = Int(likelist.reversed()[(indexPath as NSIndexPath).section][4])! % 60
        let durationtimem = (Int(likelist.reversed()[(indexPath as NSIndexPath).section][4])! - durationtimec) / 60
        cell.musicdurationlabel.text = "时长：\(durationtimem)'\(durationtimec)''"
        return cell
    }
    func contain(a:[String],b:[[String]]) -> Bool {//判断数组是否包含元素
        var c = false
        for i in b {
            if i == a {
                c = true
                break
            }else{
                c = false
            }
        }
        return c
    }
    func indexofelement(a:[String],b:[[String]]) -> Int {//定位元素在数组中的位置
        var item = 0
        for i in 0..<b.count {
            if b[i] == a {
                item = i
                break
            }
        }
        return item
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (self.tabBarController?.tabBar.isHidden)! {
            let b1 = Array(likelist.reversed())
            let cellview = tableView.cellForRow(at: indexPath) as! MusiclistTableViewCell
            if contain(a: b1[indexPath.section], b: deletelist) {
                cellview.playimage.image = UIImage(named: "choice1")
                deletelist.remove(at: deletelist.index(where: {$0 == b1[indexPath.section]})!)
            }else{
                cellview.playimage.image = UIImage(named: "choice2")
                deletelist.append(b1[indexPath.section])
            }
        }else{
            cellnub = indexPath.section
            performSegue(withIdentifier: "pushfromlike", sender: self)
        }
    }
    func done() {
        self.present(alertcontroller, animated: true, completion: nil)
    }
    func dodelete() {
        var list = likelist
        for i in deletelist {
            list.remove(at:indexofelement(a: i, b: list))
        }
        likelist = list
        setflag = 1
        set.title = "编辑"
        self.tabBarController?.tabBar.isHidden = false
        self.table.reloadData()
    }
    func choiceall() {
        let list = likelist
        if deletelist.count == likelist.count {
            //deletelist.removeAll()
            for cell in table.visibleCells{
                let vcell = cell as! MusiclistTableViewCell
                vcell.playimage.image = UIImage(named: "choice1")
            }
            deletelist.removeAll()
            allchoice.setTitle("全选", for: .normal)
        }else{
            for cell in table.visibleCells{
                let vcell = cell as! MusiclistTableViewCell
                vcell.playimage.image = UIImage(named: "choice2")
            }
            for i in 0..<list.count {
                if !contain(a: list[i], b: deletelist) {
                    deletelist.append(list[i])
                }
            }
            allchoice.setTitle("全不选", for: .normal)
            
        }
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "pushfromlike" {
            let des = segue.destination as! MusicPlayerController
            let a = Array(likelist.reversed())
            musicimage = UIImage(named: "Image-"+"\(a[cellnub][0])")!
            musictitle = "最爱"
            var musicdetillisttag1 = [String]()
            var musicaddresslisttag1 = [String]()
            var musicdurationtag1 = [String]()
            var musicaduiotime1 = [String]()
            var musicimagelist1 = [String]()
            for b in a{
                musicimagelist1.append(b[0])
                musicdetillisttag1.append(b[2])
                musicaddresslisttag1.append(b[3])
                musicdurationtag1.append(b[4])
                musicaduiotime1.append(b[5])
                //print(b[2])
            }
            musicdetillisttag = musicdetillisttag1
            musicaddresslisttag = musicaddresslisttag1
            musicdurationtag = musicdurationtag1
            musicaduiotime = musicaduiotime1
            musicimagelist = musicimagelist1
            flag1 = 1
            des.musicitemnub = cellnub
            tabInttag = tabInt
            
        }
    }
    

}
