//
//  AboutViewController.swift
//  梦蝶
//
//  Created by 叶俊中 on 16/9/16.
//  Copyright © 2016年 叶俊中. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBAction func lianxizuozhe(_ sender: UIButton) {
        let a = UIPasteboard.general
        a.string = "774524998@qq.com"
        SVProgressHUD.setMinimumDismissTimeInterval(1.0)
        SVProgressHUD.setDefaultMaskType(.none)
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.showSuccess(withStatus: "邮箱地址已复制")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //lianxi.layer.borderWidth = 1
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
