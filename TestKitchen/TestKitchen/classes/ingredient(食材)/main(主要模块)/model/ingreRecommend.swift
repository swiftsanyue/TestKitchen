//
//  ingreRecommend.swift
//  TestKitchen
//
//  Created by qianfeng on 16/10/24.
//  Copyright © 2016年 zl. All rights reserved.
//

import UIKit
import SwiftyJSON

class IngreRecommend: NSObject {
    
    var code: NSNumber?
    var data: IngreReommendData?
    var msg: NSNumber?
    var timestamp: NSNumber?
    var version: String?
    
    //解析
    class func parseData(data: NSData) -> IngreRecommend {
        
        let json = JSON(data: data)
        
        let model = IngreRecommend()
        model.code = json["code"].number
        model.data = IngreReommendData.parseModel(json["data"])
        model.msg = json["msg"].number
        model.timestamp = json["timestamp"].number
        model.version = json["version"].string
        
        return model
        
    }
    
}


class IngreReommendData: NSObject {
    
    
    var bannerArray: Array<IngreRecommedBanner>?
    var widgetList: Array<NSObject>?
    
    //解析
    class func parseModel(json: JSON) -> IngreReommendData {
        
        let model = IngreReommendData()
        
        //广告数据
        var tmpBannerArray = Array<IngreRecommedBanner>()
        
        for (_, subjson): (String,JSON) in json["bannerArray"] {
            let bannerModel = IngreRecommedBanner.parseModel(subjson)
            tmpBannerArray.append(bannerModel)
        }
        model.bannerArray = tmpBannerArray
        
        //列表数据
        var tmpList = Array<NSObject>()
        
        for (index, subjson): (String, JSON) in json["widgetList"] {
            let wModel = NSObject()
            tmpList.append(wModel)
        }
        model.widgetList = tmpList
        
        return model
    }
    
}


class IngreRecommedBanner: NSObject {
    
    var banner_id: NSNumber?
    var banner_link: String?
    var banner_picture: String?
    
    var banner_title: String?
    var is_link: NSNumber?
    var refer_key: NSNumber?
    
    var type_id: NSNumber?
    
    //解析
    class func parseModel(json: JSON) -> IngreRecommedBanner {
        let model = IngreRecommedBanner()
        model.banner_id = json["banner_id"].number
        model.banner_link = json["banner_link"].string
        model.banner_picture = json["banner_picture"].string
        
        model.banner_title = json["banner_title"].string
        model.is_link = json["is_link"].number
        model.refer_key = json["refer_key"].number
        
        model.type_id = json["type_id"].number
        
        return model
    }
    
}

