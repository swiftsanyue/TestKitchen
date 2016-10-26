//
//  IngreLikeCell.swift
//  TestKitchen
//
//  Created by qianfeng on 16/10/25.
//  Copyright © 2016年 zl. All rights reserved.
//

import UIKit

class IngreLikeCell: UITableViewCell {
    
    //闭包,由主页一步步传过来的,点击事件要用的网址
    var jumpClosure:(String->Void)?
    
    //数据
    var listModel:IngreRecommendWidgetList?{
        didSet{
            showData()
        }
    }
    
    //显示数据
    private func showData(){
        
        if listModel?.widget_data?.count > 1{
            //循环显示图片和文字
            for i in 0..<(listModel?.widget_data?.count)!-1{

                //图片
                //tag值 200 201 202 203
                let imageData = listModel?.widget_data![i]
                if imageData?.type == "image" {
                    let imageTag = 200+i/2
                    
                    let imageView = contentView.viewWithTag(imageTag)
                    if imageView?.isKindOfClass(UIImageView) == true{
                        let tmpImageView = imageView as! UIImageView
                        
                        let url = NSURL(string: (imageData?.content)!)
                        tmpImageView.kf_setImageWithURL(url, placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                    }
                }
                 //文字
                
                let textData = listModel?.widget_data![i+1]
                if textData?.type == "text" {
                    let label = contentView.viewWithTag(300+i/2)
                    if label?.isKindOfClass(UILabel) == true{
                        let tmpLabel = label as! UILabel
                        tmpLabel.text = textData?.content
                    }
                }
            }
        }
        
    }
    
    @IBAction func clickBtn(sender: UIButton) {
        
        let index = sender.tag-100
        //index 0  1  2  3
        //序号   0  2  4  6
        if index*2 < listModel?.widget_data?.count{
            let data = listModel?.widget_data![index*2]
            if data?.link != nil && jumpClosure != nil {
                jumpClosure!((data?.link)!)
            }
        }
    }
    
    //创建cell的方法
    class func createLikeCellFor(tableView:UITableView,atIndexPath indexPath:NSIndexPath,listModel:IngreRecommendWidgetList?)->IngreLikeCell{
        let cellID = "ingreLikeCellID"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellID) as? IngreLikeCell
        if nil == cell{
            cell = NSBundle.mainBundle().loadNibNamed("IngreLikeCell", owner: nil, options: nil).last as? IngreLikeCell
        }
        //显示数据
        cell?.listModel = listModel
        return cell!
        
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
