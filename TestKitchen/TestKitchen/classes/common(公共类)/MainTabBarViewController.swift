//
//  MainTabBarViewController.swift
//  TestKitchen
//
//  Created by qianfeng on 16/10/21.
//  Copyright © 2016年 zl. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    //tabbar 的背景
    private var bgView:UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //创建视图控制器
        createViewControllers()
        
        //自定制tabbar
        tabBar.hidden = true
        createMyTabBar()
        
    }
    
    //自定制tabbar
    func createMyTabBar(){
        
        //1.创建背景视图
        bgView = UIView.createView()
        bgView?.backgroundColor=UIColor(white: 0.9, alpha: 1.0)
        //设置边框
        //        bgView?.layer.borderColor = UIColor.blackColor().CGColor
        //        bgView?.layer.borderWidth = 1
        
        view.addSubview(bgView!)
        
        bgView?.snp_makeConstraints(closure: {[weak self] (make) in
            make.left.right.bottom.equalTo(self!.view)
            make.height.equalTo(49)
            })
        
        
        //图片的名字
        let imageNames = ["home","community","shop","shike","mine"]
        //标题名字
        let titles = ["食材","社区","商城","食课","我的"]
        
        //循环创建按钮
        let width = KScreenW/CGFloat(imageNames.count)
        for i in 0..<imageNames.count {
            
            let imageName = imageNames[i]+"_normal"
            let selectName = imageNames[i]+"_select"
            let btn = UIButton.createBtn(nil, bgImageName: imageName, highlightImageName: nil, selectImageName: selectName, target: self, action: #selector(clickBtn(_:)))
            //设置tag值
            btn.tag = 300+i
            
            bgView!.addSubview(btn)
            
            //设置按钮的位置
            btn.snp_makeConstraints(closure: { [weak self]
                (make) in
                make.top.bottom.equalTo(self!.bgView!)
                make.width.equalTo(width)
                make.left.equalTo(width*CGFloat(i))
                })
            
            //2.2 显示标题
            let titleLabel = UILabel.createLabel(titles[i], textAlignment: .Center, font: UIFont.systemFontOfSize(10))
            btn.addSubview(titleLabel)
            
            //设置位置
            titleLabel.snp_makeConstraints(closure: { (make) in
                make.left.right.bottom.equalTo(btn)
                make.height.equalTo(20)
            })
        }
    }
    func clickBtn(curBtn:UIButton){
        let index = curBtn.tag-300
        
        //1.1取消选中之前的按钮  selectedIndex当前选中的值
        let lastBtn = bgView?.viewWithTag(300+selectedIndex) as! UIButton
        
        if selectedIndex != index{
            lastBtn.selected = false
            lastBtn.userInteractionEnabled = true
            //1.2选中当前的按钮
            curBtn.selected = true
            curBtn.userInteractionEnabled = false
            
            //1.3切换视图控制器
            selectedIndex = index
        }
    }
    
    //创建视图控制器
    func createViewControllers(){
        //
        //        //视图控制器的名字
        let nameArray = ["IngredientViewController","CommunityViewController","MallViewController","FoodClassViewController","ProfileViewController"]
        //
        //        //图片的名字
        //        let imageNames = ["home","community","shop","shike","mine"]
        //        //标题名字
        //        let titles = ["食材","社区","商城","食课","我的"]
        //
        //
        //视图控制器对象的数组
        var ctrlArray = Array<UINavigationController>()
        for i in 0..<nameArray.count {
            //使用类名创建类的对象
            let ctrl = NSClassFromString("TestKitchen."+nameArray[i]) as! UIViewController.Type
            let vc = ctrl.init()
            //
            //            //设置文字和图片
            //            vc.tabBarItem.title = titles[i]
            //            vc.tabBarItem.image = UIImage(named: imageNames[i]+"_normal")
            //            vc.tabBarItem.selectedImage = UIImage(named: imageNames[i]+"_select")
            //导航
            let navCtrl = UINavigationController(rootViewController: vc)
            ctrlArray.append(navCtrl)
        }
        viewControllers = ctrlArray
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
