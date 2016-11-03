//
//  KTCDownloader.swift
//  TestKitchen
//
//  Created by qianfeng on 16/10/24.
//  Copyright © 2016年 zl. All rights reserved.
//

import UIKit
import Alamofire

protocol KTCDownloaderDelegate:NSObjectProtocol {
    //下载失败的方法
    func downloader(downloader:KTCDownloader,didFailWithError error:NSError)
    //下载成功
    func downloader(downloder:KTCDownloader,didFinishWithData data:NSData?)
}

class KTCDownloader: NSObject {
    
    //代理属性 代理一定要用弱引用
    weak var dalegate:KTCDownloaderDelegate?
    
    //下载类型
    var downloadType:KTCDownloadType = .Normal
    
    //POST 请求
    func postWithUrl(urlString:String,params:Dictionary<String,AnyObject>){
        //methodName=MaterialSubtype&token=&user_id=&version=4.32
        var tmpDict = NSDictionary(dictionary: params) as! Dictionary<String,AnyObject>
        //设置所有接口的公共参数
        tmpDict["token"] = ""
        tmpDict["user_id"] = ""
        tmpDict["version"] = "4.5"
        
        Alamofire.request(.POST,urlString, parameters: tmpDict, encoding: ParameterEncoding.URL, headers: nil).responseData { (response) in
            switch response.result{
            case .Failure(let error):
                //出错了
                self.dalegate?.downloader(self, didFailWithError: error)
                
            case .Success :
                //下载成功
                self.dalegate?.downloader(self, didFinishWithData: response.data)
            }
        }
    }
}

enum KTCDownloadType: Int {
    case Normal = 0
    case IngreRecommend      //首页食材的推荐
    case IngreMaterial       //首页食材的食材
    case IngreCategory       //首页食材的分类
    
    case IngreFoodCourseDetail  //食材课程的详情
    case IngreFoodCourseComment  //食材课程的评论
}





