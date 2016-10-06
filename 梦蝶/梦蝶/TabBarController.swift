//
//  ViewController.swift
//  梦蝶
//
//  Created by 叶俊中 on 16/9/16.
//  Copyright © 2016年 叶俊中. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        self.tabBar.items?[0].image = UIImage(named: "home")
        self.tabBar.items?[0].selectedImage = UIImage(named: "home")
        self.tabBar.items?[1].image = UIImage(named: "tablike")
        self.tabBar.items?[1].selectedImage = UIImage(named: "tablike")
        self.tabBar.items?[2].image = UIImage(named: "set")
        self.tabBar.items?[2].selectedImage = UIImage(named: "set")
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

