//
//  IngredientViewController.swift
//  TestKitchen
//
//  Created by qianfeng on 16/10/21.
//  Copyright © 2016年 zl. All rights reserved.
//

import UIKit

class IngredientViewController: BaseViewController {
    
    var model = IngreRecommend()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //滚动视图或者其子视图放在导航下面，会自动加一个上面的间距，我们要取消这个间距
        automaticallyAdjustsScrollViewInsets = false
        //创建导航
        createNav()
        //下载首页的推荐数据
        downloadRecommendData()
        

        
    }
    func createNav(){
        //扫一扫
        addNavBtn("saoyisao", target: self, action: #selector(scanAction), isLeft: true)
        
        //搜索
        addNavBtn("search", target: self, action: #selector(searchAction), isLeft: false)
    }
    
    //扫一扫
    func scanAction(){
        print("1")
    }
    func searchAction(){
        print("2")
    }
    
    //下载首页的推荐数据
    func downloadRecommendData(){
        //methodName=SceneHome&token=&user_id=&version=4.5
        let params = ["methodName":"SceneHome","token":"","user_id":"","version":"4.5"]
        let downloader = KTCDownloader()
        downloader.dalegate = self
        downloader.postWithUrl(kHostUrl, params: params)
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

//MARK: KTCDownloader 代理方法
extension IngredientViewController:KTCDownloaderDelegate {
    //下载失败
    func downloader(downloader: KTCDownloader, didFailWithError error: NSError) {
        print(error)
    }
    //下载成功
    func downloader(downloder: KTCDownloader, didFinishWithData data: NSData?) {
        let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
        print(str)
        if let tmpData = data {
            //1.json解析
        let recommendModel = IngreRecommend.parseData(tmpData)

        
        //判断是否是主线程
//        print(NSThread.currentThread())
        //2.显示UI
        let recommendView = IngreRecommendView(frame: CGRectZero)
        recommendView.model = recommendModel
            view.addSubview(recommendView)
            self.model=recommendModel
            
        //3.点击食材的推荐页面的某一个部分，跳转到后面的界面的时候传值用的闭包
            recommendView.jumpClosure = {
                jumpUrl in
                print(jumpUrl)
            }
            
            
            //约束
            recommendView.snp_makeConstraints(closure: { (make) in
                make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(64, 0, 49, 0))
            })
            
        }
    }
}





