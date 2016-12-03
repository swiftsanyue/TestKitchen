//
//  KTCTabViewController.swift
//  TestKitchen
//
//  Created by ZL on 16/11/4.
//  Copyright © 2016年 zl. All rights reserved.
//

import UIKit

class KTCTabViewController: BaseViewController {
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //显示
        let appDele = UIApplication.sharedApplication().delegate as! AppDelegate
        let mainCtrl = appDele.window?.rootViewController as! MainTabBarViewController
        mainCtrl.hideTabBar()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        //隐藏
        let appDele = UIApplication.sharedApplication().delegate as! AppDelegate
        let mainCtrl = appDele.window?.rootViewController as! MainTabBarViewController
        mainCtrl.showTabBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
