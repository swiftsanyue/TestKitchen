//
//  ingreRecommend.swift
//  TestKitchen
//
//  Created by ZL on 16/10/24.
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
    
    
    var banner: Array<IngreRecommendBanner>?
    var widgetList: Array<IngreRecommendWidgetList>?
    
    //解析
    class func parseModel(json: JSON) -> IngreReommendData {
        
        let model = IngreReommendData()
        
        //广告数据
        var tmpBannerArray = Array<IngreRecommendBanner>()
        
        for (_, subjson): (String,JSON) in json["banner"] {
            let bannerModel = IngreRecommendBanner.parseModel(subjson)
            tmpBannerArray.append(bannerModel)
        }
        model.banner = tmpBannerArray
        
        //列表数据
        var tmpList = Array<IngreRecommendWidgetList>()
        
        for (_, subjson): (String, JSON) in json["widgetList"] {
            let wModel = IngreRecommendWidgetList.parseModel(subjson)
            tmpList.append(wModel)
        }
        model.widgetList = tmpList
        
        return model
    }
    
}


class IngreRecommendBanner: NSObject {
    
    var banner_id: NSNumber?
    var banner_link: String?
    var banner_picture: String?
    
    var banner_title: String?
    var is_link: NSNumber?
    var refer_key: NSNumber?
    
    var type_id: NSNumber?
    
    //解析
    class func parseModel(json: JSON) -> IngreRecommendBanner {
        let model = IngreRecommendBanner()
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

class IngreRecommendWidgetList: NSObject{
    var desc: String?
    var title: String?
    var title_link:String?
    var widget_data:Array<IngreRecommendWidgetData>?
    var widget_id:NSNumber?
    var widget_type:NSNumber?
    
    class func parseModel(json: JSON)->IngreRecommendWidgetList{
        let model = IngreRecommendWidgetList()
        model.desc = json["desc"].string
        model.title = json["title"].string
        model.title_link = json["title_link"].string
        var dataArray = Array<IngreRecommendWidgetData>()
        for (_,Subjson): (String,JSON) in json["widget_data"] {
            let subModel = IngreRecommendWidgetData.parseModel(Subjson)
            dataArray.append(subModel)
        }
        model.widget_data = dataArray
        model.widget_id = json["widget_id"].number
        model.widget_type = json["widget_type"].number
        return model
    }
}

class IngreRecommendWidgetData:NSObject{
    var content:String?
    var id:NSNumber?
    var link:String?
    var type:String?
    
    class func parseModel(json: JSON)->IngreRecommendWidgetData {
        let model=IngreRecommendWidgetData()
        model.content = json["content"].string
        model.id = json["id"].number
        model.link = json["link"].string
        model.type = json["type"].string
        return model
    }
}
