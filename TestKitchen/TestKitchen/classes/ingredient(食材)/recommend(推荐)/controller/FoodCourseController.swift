//
//  FoodCourseController.swift
//  TestKitchen
//
//  Created by qianfeng on 16/11/3.
//  Copyright © 2016年 zl. All rights reserved.
//

import UIKit

class FoodCourseController: BaseViewController {
    
    //id 
    var courseId:String?
    
    //表格 
    var tbView:UITableView?
    
    //详情的数据
    private var detailData : FoodCourseDetail?
    
    //创建表格
    func creatrTableView(){
        automaticallyAdjustsScrollViewInsets = false
        
        tbView = UITableView(frame: CGRectZero,style: .Plain)
        tbView?.delegate = self
        tbView?.dataSource = self
        view.addSubview(tbView!)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //创建表格
        creatrTableView()
        //下载详情的数据
        downloadDetailData()
        
        

        
    }
    
    //下载详情的数据
    func downloadDetailData(){
        
        if courseId != nil {
            let params = ["methodName":"CourseSeriesView","series_id":"\(courseId!)"]
            
            let downloader = KTCDownloader()
            downloader.dalegate = self
            downloader.downloadType = .IngreFoodCourseDetail
            downloader.postWithUrl(kHostUrl, params: params)
            

            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension FoodCourseController:KTCDownloaderDelegate{
    
    //下载失败的方法
    func downloader(downloader:KTCDownloader,didFailWithError error:NSError){
        
    }
    //下载成功
    func downloader(downloder:KTCDownloader,didFinishWithData data:NSData?){
        if downloder.downloadType == .IngreFoodCourseDetail{
//            let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
//            print(str)
            //详情
            if let tmpData = data {
                detailData = FoodCourseDetail.parseData(tmpData)
                //显示数据
                
                
                
            }
            
        }else if downloder.downloadType == .IngreFoodCourseComment{
            //评论
        }
    }
}



//MARK: UITableView代理
extension FoodCourseController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
}









