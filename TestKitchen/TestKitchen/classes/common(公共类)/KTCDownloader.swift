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
    
    //POST 请求
    func postWithUrl(urlString:String,params:Dictionary<String,AnyObject>){
        
        Alamofire.request(.POST,urlString, parameters: params, encoding: ParameterEncoding.URL, headers: nil).responseData { (response) in
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
