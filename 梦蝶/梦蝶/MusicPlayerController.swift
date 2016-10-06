//
//  MusicPlayerController.swift
//  梦蝶
//
//  Created by 叶俊中 on 16/9/16.
//  Copyright © 2016年 叶俊中. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

let defaults = UserDefaults.standard
class MusicPlayerController: UIViewController {
    var MusicImage :UIImageView!
    var slideroutlet: UISlider!
    var musicnameLabel: UILabel!
    var durationTimeLabel: UILabel!
    var currentTimeLabel: UILabel!
    var playbutton: UIButton!
    var gobackButton : UIButton!
    var goforwardButton1 : UIButton!
    var musicitemnub :Int?
    var backgroundImage : UIImageView!
    var dismissviewButton: UIButton!
    var titlelable:UILabel!
    var playmodel:UIButton!
    var likeButton:UIButton!
    var clockbutton:UIButton!
    var clocklabel:UILabel!
    var durationTimeForinfo = 0
    
    var playmodelflag:Int{//0,1,2
        set(newvalue){
            defaults.set(newvalue, forKey: "playmode")
            SVProgressHUD.setMinimumDismissTimeInterval(0.3)
            switch newvalue {
            case 0:
                playmodel.setBackgroundImage(UIImage(named: "0"), for:UIControlState())
                SVProgressHUD.showSuccess(withStatus: "顺序播放")
            case 1:
                playmodel.setBackgroundImage(UIImage(named: "1"), for:UIControlState())
                SVProgressHUD.showSuccess(withStatus: "随机播放")
            case 2:
                playmodel.setBackgroundImage(UIImage(named: "2"), for:UIControlState())
                SVProgressHUD.showSuccess(withStatus: "单曲循环")
            default:
                break
            }
            
        }
        get{
            if let a = defaults.object(forKey: "playmode") {
                return a as! Int
            }else{
                defaults.set(0, forKey: "playmode")
                playmodel.setBackgroundImage(UIImage(named: "0"), for:UIControlState())
                return 0
            }
        }
    }
    var alertcontroller = UIAlertController(title: "定时停止播放", message: nil, preferredStyle: .actionSheet)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let aler = ["10分钟","15分钟","30分钟","60分钟"]
        for i in 0...3 {
            alertcontroller.addAction(UIAlertAction(title: aler[i], style: .default,handler:{ (UIAlertAction) in
                self.clockbutton.setBackgroundImage(UIImage(named:"redclock"), for: UIControlState())
                time0 = 0
                timeing = i
                
            } ))
        }
        alertcontroller.addAction(UIAlertAction(title: "当前节目播放完后", style: .default, handler: { (UIAlertAction) in
            self.clockbutton.setBackgroundImage(UIImage(named:"redclock"), for: UIControlState())
            time0 = 0
            timeing = 4
            self.clocklabel.text = "单曲"
        }))
        alertcontroller.addAction(UIAlertAction(title: "关闭定时", style: .default, handler: { (UIAlertAction) in
            time0 = 0
            timevalue = nil
            timeing = -1
            self.clockbutton.setBackgroundImage(UIImage(named:"clock"), for: UIControlState())
            self.clocklabel.text = ""
        }))
        alertcontroller.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        let blurEffect = UIBlurEffect(style: .dark)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.alpha = 1
        dismissviewButton = UIButton(frame: CGRect(x: 15,y: 30,width: 30,height: 25))
        dismissviewButton.setImage(UIImage(named: "back"), for: UIControlState())
        playmodel = UIButton(frame:CGRect(x: 15,y: UIScreen.main.bounds.height - 65,width: 50,height: 50))
        switch playmodelflag {
        case 0:
            playmodel.setBackgroundImage(UIImage(named: "0"), for:UIControlState())
        case 1:
            playmodel.setBackgroundImage(UIImage(named: "1"), for:UIControlState())
        case 2:
            playmodel.setBackgroundImage(UIImage(named: "2"), for:UIControlState())
        default:
            break
        }
        likeButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width / 2 - 25,y: UIScreen.main.bounds.height - 65,width: 50,height: 50))
        likeButton.setBackgroundImage(UIImage(named: "unlike"), for: UIControlState())
        clockbutton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - 65,y: UIScreen.main.bounds.height - 65,width: 50,height: 50))
        clockbutton.setBackgroundImage(UIImage(named:"clock"), for: UIControlState())
        clocklabel = UILabel(frame: CGRect(x: UIScreen.main.bounds.width - 70,y: UIScreen.main.bounds.height - 15,width: 60,height: 15))
        clocklabel.textAlignment = .center
        clocklabel.textColor = UIColor(red: 121 / 255, green: 121 / 255, blue: 121 / 255, alpha: 1)
        //clockbutton.setTitle("定时", for: UIControlState())
        //clockbutton.setTitleColor(UIColor.white, for: UIControlState())
        titlelable = UILabel(frame: CGRect(x: 45,y: 30,width: UIScreen.main.bounds.width - 90,height: 25))
        titlelable.textColor = UIColor.white
        backgroundImage = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        backgroundImage.image = musicimage
        visualEffectView.frame = backgroundImage.bounds
        backgroundImage.addSubview(visualEffectView)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        MusicImage = UIImageView(frame: CGRect(x: UIScreen.main.bounds.width / 6, y: (UIScreen.main.bounds.height / 2 - UIScreen.main.bounds.width / 2) * 2 / 3, width: UIScreen.main.bounds.width * 2 / 3, height: UIScreen.main.bounds.width * 2 / 3))
        musicnameLabel = UILabel(frame: CGRect(x: 0,y: MusicImage.frame.origin.x + UIScreen.main.bounds.width * 2 / 3 + 50,width: UIScreen.main.bounds.width,height: 50))
        musicnameLabel.textColor = UIColor.white
        slideroutlet = UISlider(frame: CGRect(x: 65,y: MusicImage.frame.origin.x + UIScreen.main.bounds.width * 2 / 3 + 100,width: UIScreen.main.bounds.width - 130,height: 50))
        currentTimeLabel = UILabel(frame: CGRect(x: 20,y: MusicImage.frame.origin.x + UIScreen.main.bounds.width * 2 / 3 + 100,width: 55,height: 50))
        currentTimeLabel.textColor = UIColor.white
        durationTimeLabel = UILabel(frame: CGRect(x: UIScreen.main.bounds.width - 65,y: MusicImage.frame.origin.x + UIScreen.main.bounds.width * 2 / 3 + 100,width: 55,height: 50))
        durationTimeLabel.textColor = UIColor.white
        playbutton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width / 2 - 40,y: durationTimeLabel.frame.origin.y + 60,width: 80,height: 80))
        gobackButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width / 3 - 50,y: durationTimeLabel.frame.origin.y + 75,width: 50,height: 50))
        goforwardButton1 = UIButton(frame: CGRect(x: UIScreen.main.bounds.width * 2 / 3,y: durationTimeLabel.frame.origin.y + 75,width: 50,height: 50))
        if isplay {
            playbutton.setBackgroundImage(UIImage(named: "stop"), for: UIControlState())
        }else{
            playbutton.setBackgroundImage(UIImage(named: "play"), for: UIControlState())
        }
        gobackButton.setBackgroundImage(UIImage(named: "go-back"), for: UIControlState())
        goforwardButton1.setBackgroundImage(UIImage(named: "go-forward"), for: UIControlState())
        musicnameLabel.textAlignment = .center
        durationTimeLabel.textAlignment = .center
        currentTimeLabel.textAlignment = .center
        titlelable.textAlignment = .center
        self.view.addSubview(backgroundImage)
        self.view.addSubview(dismissviewButton)
        self.view.addSubview(MusicImage)
        self.view.addSubview(musicnameLabel)
        self.view.addSubview(slideroutlet)
        self.view.addSubview(currentTimeLabel)
        self.view.addSubview(durationTimeLabel)
        self.view.addSubview(playbutton)
        self.view.addSubview(goforwardButton1)
        self.view.addSubview(gobackButton)
        self.view.addSubview(titlelable)
        self.view.addSubview(playmodel)
        self.view.addSubview(likeButton)
        self.view.addSubview(clockbutton)
        self.view.addSubview(clocklabel)
        playbutton.addTarget(self, action: #selector(playbuttonAction), for: .touchUpInside)
        gobackButton.addTarget(self, action: #selector(goback), for: .touchUpInside)
        goforwardButton1.addTarget(self, action: #selector(goforward), for: .touchUpInside)
        slideroutlet.addTarget(self, action: #selector(SliderChange), for:.touchUpInside)
        dismissviewButton.addTarget(self, action: #selector(gobackView), for: .touchUpInside)
        playmodel.addTarget(self, action: #selector(playMode), for: .touchUpInside)
        clockbutton.addTarget(self, action: #selector(timeingcotroll), for: .touchUpInside)
        likeButton.addTarget(self, action: #selector(like), for: .touchUpInside)
        MusicImage.image = musicimage
        titlelable.text = musictitle
        if flag1 == 1 {//是否从detel进入
            //是detel
            if urltag != musicaddresslisttag[musicitemnub!] {//是否同一首歌
                //否
                player.replaceCurrentItem(with: AVPlayerItem(url: URL(string:musicaddresslisttag[musicitemnub!])!))
                player.play()
                isplay = true
            }
            //是
            tag = musicitemnub
            self.initScurbberTimer()
            update(tag!)
        }else{
            //否detel
            if tag != nil {//是否正在播放
                //是
                self.initScurbberTimer()
                update(tag!)
            }else{
                if defaults.value(forKey:"musicCurrentTime") != nil{
                    //取缓存
                    musictitle = defaults.value(forKey: "musicTitle") as! String
                    titlelable.text = musictitle
                    musicdetillisttag = defaults.value(forKey: "musicDetilName") as! [String]
                    musicaddresslisttag = defaults.value(forKey:"musicUrl") as! [String]
                    musicdurationtag = defaults.value(forKey:"musicDurationTime") as! [String]
                    musicimagelist = defaults.value(forKey:"musicImage") as! [String]
                    tag = defaults.value(forKey:"nowPlayId") as? Int
                    let currentTime = defaults.value(forKey:"musicCurrentTime") as! Int
                    //根据缓存初始化界面
                    player.replaceCurrentItem(with: AVPlayerItem(url: URL(string:musicaddresslisttag[tag!])!))
                    durationTimeForinfo = Int(musicdurationtag[tag!])!
                    musicnameLabel.text = musicdetillisttag[tag!]
                    durationTimeLabel.text = "\((Int(musicdurationtag[tag!])! - Int(musicdurationtag[tag!])! % 60) / 60)"+":"+"\(Int(musicdurationtag[tag!])! % 60)"
                    currentTimeLabel.text = "\((Int(currentTime) - Int(currentTime) % 60) / 60)" + ":" + "\(Int(currentTime) % 60)"
                    slideroutlet.minimumValue = 0.0
                    slideroutlet.maximumValue = Float(musicdurationtag[tag!])!
                    slideroutlet.value = Float(currentTime)
                    urltag = musicaddresslisttag[tag!]
                    playbutton.setBackgroundImage(UIImage(named: "play"), for: UIControlState())
                    var likeurllist = [String]()
                    for a in likelist{
                        likeurllist.append(a[3])
                    }
                    if likeurllist.contains(urltag!) {
                        likeButton.setBackgroundImage(UIImage(named:"like"), for: UIControlState())
                    }else{
                        likeButton.setBackgroundImage(UIImage(named:"unlike"), for: UIControlState())
                    }
                    musicimage = UIImage(named: "Image-"+"\(musicimagelist[tag!])")!
                    MusicImage.image = musicimage
                    backgroundImage.image = musicimage
                    self.configNowPlayingCenter()
                    self.initScurbberTimer()
                    player.seek(to: CMTimeMake(Int64(slideroutlet.value), 1))
                    self.configNowPlayingCenter()
                }else{
                musicnameLabel.text = ""
                durationTimeLabel.text = "0:0"
                currentTimeLabel.text = "0:0"
                slideroutlet.minimumValue = 0.0
                slideroutlet.maximumValue = 1
                slideroutlet.value = 0
                }
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.beginReceivingRemoteControlEvents()//远程控制，后台退出时关闭
        self.resignFirstResponder()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        if isplay{
            player.play()
            if timeing >= 0 {
                clockbutton.setBackgroundImage(UIImage(named:"redclock"), for: UIControlState())
                if timeing == 4 {
                    clocklabel.text = "单曲"
                }
            }
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        self.becomeFirstResponder()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        flag1 = 0
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
    }
    override var canBecomeFirstResponder: Bool{
        return true
    }
    override func remoteControlReceived(with event: UIEvent?) {//远程控制
        if event != nil {
            if event?.type == UIEventType.remoteControl{
                switch event!.subtype {
                case UIEventSubtype.remoteControlTogglePlayPause:
                    player.pause()
                    isplay = false
                    playbutton.setBackgroundImage(UIImage(named: "play"), for: UIControlState())
                case UIEventSubtype.remoteControlPreviousTrack:
                    self.goback()
                case UIEventSubtype.remoteControlNextTrack:
                    self.goforward()
                case UIEventSubtype.remoteControlPlay:
                    self.playbuttonAction()
                case UIEventSubtype.remoteControlPause:
                    self.playbuttonAction()
                default:
                    break
                }
            }
        }
    }
    func configNowPlayingCenter() {//配置底部上拉菜单界面及锁屏界面
        //MPNowPlayingInfoCenter.default().nowPlayingInfo = nil
        MPNowPlayingInfoCenter.default().nowPlayingInfo = [MPMediaItemPropertyTitle:self.musicnameLabel.text!,MPMediaItemPropertyArtist:self.titlelable.text!,MPNowPlayingInfoPropertyElapsedPlaybackTime:"\(CMTimeGetSeconds(player.currentTime()))",MPNowPlayingInfoPropertyPlaybackRate:1,MPMediaItemPropertyPlaybackDuration:"\(durationTimeForinfo)",MPMediaItemPropertyArtwork:MPMediaItemArtwork(image:self.MusicImage.image!)]
    }
    func like() {//最爱按钮
        if let a = tag{
            var list = [String]()
            for i in likelist {
                list.append(i[3])
            }
            if !list.contains(musicaddresslisttag[a]) {
                likelist.append([String(tabInttag),musictitle,musicdetillisttag[a],musicaddresslisttag[a],musicdurationtag[a],musicaduiotime[a]])
                //专辑号，专辑名，歌曲名，歌曲URL，歌曲持续时间，歌曲发布时间
                likeButton.setBackgroundImage(UIImage(named:"like"),for: UIControlState())
            }else{
                var b = likelist
                let index = indexofelement(a: musicaddresslisttag[a], b: list)
                b.remove(at: index)
                likelist = b
                likeButton.setBackgroundImage(UIImage(named:"unlike"), for: UIControlState())
            }
        }
    }
    func indexofelement(a:String,b:[String]) -> Int {//定位元素在数组中的位置
        var item = 0
        for i in 0..<b.count {
            if b[i] == a {
                item = i
                break
            }
        }
        return item
    }
    func update(_ itemnub:Int) {
        durationTimeForinfo = Int(musicdurationtag[itemnub])!
        musicnameLabel.text = musicdetillisttag[itemnub]
        durationTimeLabel.text = "\((Int(musicdurationtag[itemnub])! - Int(musicdurationtag[itemnub])! % 60) / 60)"+":"+"\(Int(musicdurationtag[itemnub])! % 60)"
        currentTimeLabel.text = "\((Int(CMTimeGetSeconds(player.currentTime())) - Int(CMTimeGetSeconds(player.currentTime())) % 60) / 60)" + ":" + "\(Int(CMTimeGetSeconds(player.currentTime())) % 60)"
        slideroutlet.minimumValue = 0.0
        slideroutlet.maximumValue = Float(musicdurationtag[itemnub])!
        slideroutlet.value = Float(CMTimeGetSeconds(player.currentTime()))
        urltag = musicaddresslisttag[itemnub]
        playbutton.setBackgroundImage(UIImage(named: "stop"), for: UIControlState())
        var likeurllist = [String]()
        for a in likelist{
            likeurllist.append(a[3])
        }
        if likeurllist.contains(urltag!) {
            likeButton.setBackgroundImage(UIImage(named:"like"), for: UIControlState())
        }else{
            likeButton.setBackgroundImage(UIImage(named:"unlike"), for: UIControlState())
        }
        
        if titlelable.text == "最爱" {
            musicimage = UIImage(named: "Image-"+"\(musicimagelist[itemnub])")!
            MusicImage.image = musicimage
            backgroundImage.image = musicimage
        }
        self.configNowPlayingCenter()
    }
    func timeingcotroll() {//定时器底部弹出惨淡
        if isplay {
            self.present(alertcontroller,animated:true,completion:nil)
        }
    }
    func playMode() {
        switch playmodelflag {
        case 0://顺序
            playmodelflag = 1
        case 1://随机
            playmodelflag = 2
        case 2://单曲循环
            playmodelflag = 0
        default:
            break
        }
        //playmodel.setTitle(String(playmodelflag), for: UIControlState())
    }
    func gobackView() {
        weak var weakself = self
        _ = weakself?.navigationController?.popViewController(animated: true)
    }
    func SliderChange() {
        self.configNowPlayingCenter()
        player.seek(to: CMTimeMake(Int64(slideroutlet.value), 1))
        
    }
    func playbuttonAction() {
        if isplay{
            player.pause()
            isplay = false
            playbutton.setBackgroundImage(UIImage(named: "play"), for: UIControlState())
        }else{
            player.play()
            isplay = true
            playbutton.setBackgroundImage(UIImage(named: "stop"), for: UIControlState())
        }
        self.configNowPlayingCenter()
    }
    func goforward() {
        if tag! + 1 >= musicdurationtag.count{
            tag! = 0
        }else{
            tag! = tag! + 1
        }
        player.replaceCurrentItem(with: AVPlayerItem(url: URL(string:musicaddresslisttag[tag!])!))
        player.play()
        isplay = true
        //playbutton.setBackgroundImage(UIImage(named: "stop"), for: UIControlState())
        self.update(tag!)
    }
    func goback() {
        if tag! == 0{
            tag! = musicdurationtag.count - 1
        }else{
            tag! = tag! - 1
        }
        player.replaceCurrentItem(with: AVPlayerItem(url: URL(string:musicaddresslisttag[tag!])!))
        player.play()
        isplay = true
        //playbutton.setBackgroundImage(UIImage(named: "stop"), for: UIControlState())
        self.update(tag!)
    }
    func initScurbberTimer() {//时间监视器，用于监测播放进度，刷新slider
        weak var weakself = self
        if let a = playbackObserver{
            player.removeTimeObserver(a)
            playbackObserver = nil
        }
        playbackObserver = player.addPeriodicTimeObserver(forInterval: CMTimeMake(1, 1), queue:nil, using: { (_) in
            //self.configNowPlayingCenter()
            if isplay{
            if let a = timevalue{
                if time0 < a * 60{
                    time0 = time0 + 1
                    let c = a * 60 - time0
                    self.clocklabel.text = "\((c - c % 60) / 60)" + ":" + "\(c % 60)"
                }else{
                    player.pause()
                    isplay = false
                    weakself!.playbutton.setBackgroundImage(UIImage(named: "play"), for: UIControlState())
                    time0 = 0
                    timevalue = nil
                    timeing = -1
                    self.clockbutton.setBackgroundImage(UIImage(named:"clock"), for: UIControlState())
                    self.clocklabel.text = ""
                }
            }
            let time = player.currentTime()
            let time1 = Int(CMTimeGetSeconds(time))
                //print("\(time1)")
            weakself!.slideroutlet.value = Float(CMTimeGetSeconds(time))
            weakself!.currentTimeLabel.text = "\((time1 - time1 % 60) / 60)" + ":" + "\(time1 % 60)"
            if time1 == Int(musicdurationtag[tag!]){
                if timeing == 4{
                    player.pause()
                    isplay = false
                    weakself!.playbutton.setBackgroundImage(UIImage(named: "play"), for: UIControlState())
                    time0 = 0
                    timevalue = nil
                    timeing = -1
                    self.clockbutton.setBackgroundImage(UIImage(named:"clock"), for: UIControlState())
                    self.clocklabel.text = ""
                }else{
                switch self.playmodelflag{
                case 0://顺序播放
                    if tag! == 0{
                        tag = musicdurationtag.count
                    }else{
                        tag = tag! - 1
                    }
                    player.replaceCurrentItem(with: AVPlayerItem(url: URL(string:musicaddresslisttag[tag!])!))
                    player.play()
                    self.update(tag!)
                case 1://随机播放
                    let a = Int(arc4random()) % musicdurationtag.count
                    tag = a
                    player.replaceCurrentItem(with: AVPlayerItem(url: URL(string:musicaddresslisttag[tag!])!))
                    player.play()
                    self.update(tag!)
                case 2://单曲循环
                    player.replaceCurrentItem(with: AVPlayerItem(url: URL(string:musicaddresslisttag[tag!])!))
                    player.play()
                        self.configNowPlayingCenter()
                default:
                    break
                }
                }
            }
            }
        }) as AnyObject?
    }
}
