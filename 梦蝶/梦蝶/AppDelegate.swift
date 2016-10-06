//
//  AppDelegate.swift
//  梦蝶
//
//  Created by 叶俊中 on 16/9/16.
//  Copyright © 2016年 叶俊中. All rights reserved.
//

import UIKit
import AVFoundation

var playinfo :Any?//{
//set(newvalue){
//    defaults.set(newvalue, forKey: "playinfo")
//}
//get{
//    if let a = defaults.value(forKey: "playinfo"){
//        return a as? NSDictionary
//    }else{
//        return nil
//    }
//}
//}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let sharedInstance = AVAudioSession()
        do{
            try sharedInstance.setCategory(AVAudioSessionCategoryPlayback)
        } catch {
            
        }
        Thread.sleep(forTimeInterval: 2.0)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        //软件退出是存播放列表，播放时间，当前歌曲tab
        UIApplication.shared.endReceivingRemoteControlEvents()
        defaults.set(musictitle, forKey: "musicTitle")//专辑名
        defaults.set(musicdetillisttag, forKey: "musicDetilName")//歌曲名列表
        defaults.set(musicaddresslisttag, forKey: "musicUrl")//歌曲url列表
        defaults.set(musicdurationtag, forKey: "musicDurationTime")//歌曲时长列表
        defaults.set(musicimagelist, forKey: "musicImage")//歌曲图片列表
        defaults.set(tag, forKey: "nowPlayId")//正在播放歌曲的id号
        defaults.set(CMTimeGetSeconds(player.currentTime()), forKey: "musicCurrentTime")//正在播放的时间
        //专辑名，歌曲名列表，歌曲url列表，歌曲时长列表，歌曲图片列表，正在播放歌曲的id号，正在播放的时间
        
    }
}

