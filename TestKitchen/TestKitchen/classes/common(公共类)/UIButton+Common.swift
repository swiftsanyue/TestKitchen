//
//  UIButton+Common.swift
//  TestKitchen
//
//  Created by ZL on 16/10/21.
//  Copyright © 2016年 zl. All rights reserved.
//


import UIKit

extension UIButton {
    class func createBtn(title:String?,bgImageName:String?,highlightImageName:String?,selectImageName:String?,target:AnyObject?,action:Selector)->UIButton {
        let btn = UIButton(type: .Custom)
        if let tmpTitle = title {
            btn.setTitle(tmpTitle, forState: .Normal)
            btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        }
        if let tmpBgImageName = bgImageName {
            btn.setBackgroundImage(UIImage(named: tmpBgImageName), forState: .Normal)
        }
        if let tmpHighlightName = highlightImageName {
            btn.setBackgroundImage(UIImage(named: tmpHighlightName), forState: .Highlighted)
        }
        if let tmpselectImageName = selectImageName {
            btn.setBackgroundImage(UIImage(named: tmpselectImageName), forState: .Selected)
        }
        if target != nil && action != nil {
            btn.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        }
        return btn
    }
}






