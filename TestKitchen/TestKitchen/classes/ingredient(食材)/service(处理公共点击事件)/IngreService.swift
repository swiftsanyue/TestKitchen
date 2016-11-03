//
//  IngreService.swift
//  TestKitchen
//
//  Created by qianfeng on 16/11/3.
//  Copyright © 2016年 zl. All rights reserved.
//

import UIKit

//Factory 工厂模式

class IngreService: NSObject {
    
    class func handleEvent(urlString: String,onViewController vc: UIViewController){
        //字符串包含的开头
        if urlString.hasPrefix("app://food_course_series") {
            //食材课程的分集显示
            
            let array = urlString.componentsSeparatedByString("#")
            if array.count > 1 {
                let courseId = array[1]
                FoodCourseService.handleFoodCourse(courseId, onViewController: vc)
                print(courseId)
            }
            
            
        }
        
    }

}
