//
//  musiclist.swift
//  梦蝶
//
//  Created by 叶俊中 on 16/9/16.
//  Copyright © 2016年 叶俊中. All rights reserved.
//

import UIKit
import AVFoundation


let musicnamelist = ["给失眠讲故事","给同样失眠的你","重度失眠症患者","insomnia失眠就听歌","失眠症患者","午夜电台 致失眠的你","东方暮白 专制失眠～","失眠的爱情"]
let musicuper = ["雕刻时光小鱼君","凌峰。","吴琼","comes and goes","沐艺sunly","叶馨然","马樱酒","温情男伤音"]
let musiclist1 = ["10346","249394","1413630","1339812","55746","87202","1803121","789517"]
var data13 : String = ""
var tabInt = 0//专辑号暂存
var tabInttag = 0//最终选择的专辑号
var cellnub = 0
var player = AVPlayer()
var isplay = false
var musicdetillist = [String]()//音乐名
var musicaddresslist = [String]()//url
var musicduration = [String]()//发布日期
var musicaduiotime = [String]()//持续时间
var musicimagelist = [String]()
var musicimage = UIImage()
var musictitle :String = ""
var flag = 0
var flag1 = 0
var playbackObserver :AnyObject?
var tag :Int?//正在播放
var urltag :String?//正在播放url
var musicdetillisttag = [String]()//正在播放音乐名
var musicaddresslisttag = [String]()//正在播放url
var musicdurationtag = [String]()//正在播放持续时间
var playmodelflag = 0
var timevalue:Int? = nil
var time0 = 0
var timeing = -1{
willSet(newValue){
    switch newValue{
    case 0: timevalue = 10
        timelabletext = "10分钟"
    case 1: timevalue = 15
        timelabletext = "15分钟"
    case 2: timevalue = 30
        timelabletext = "30分钟"
    case 3: timevalue = 60
        timelabletext = "60分钟"
    case 4:timelabletext = "单曲"
    default : timevalue = nil
        timelabletext = "未开启"
    }
}
}
