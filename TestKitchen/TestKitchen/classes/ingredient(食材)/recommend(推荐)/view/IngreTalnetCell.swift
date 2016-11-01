//
//  IngreTalnetCell.swift
//  TestKitchen
//
//  Created by qianfeng on 16/10/31.
//  Copyright © 2016年 zl. All rights reserved.
//

import UIKit

class IngreTalnetCell: UITableViewCell {

    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var leftImageView: UIImageView!
    
    @IBOutlet weak var fansLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    //显示数据
    var cellArray: Array<IngreRecommendWidgetData>? {
        didSet {
            showData()
        }
    }
    
    //点击事件
    var jumpClosure: IngreJumpClosure?
    
    
    func showData() {
        
        //图片
        if cellArray?.count > 0 {
            let imageData = cellArray![0]
            if imageData.type == "image" {
                let url = NSURL(string: imageData.content!)
                leftImageView.kf_setImageWithURL(url!, placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                //设置圆角
                leftImageView.layer.cornerRadius = 30
                leftImageView.layer.masksToBounds = true
            }
        }
        
        //标题
        if cellArray?.count > 1 {
            let titleData = cellArray![1]
            if titleData.type == "text" {
                nameLabel.text = titleData.content
            }
        }
        
        //描述文字
        if cellArray?.count > 2 {
            let descData = cellArray![2]
            if descData.type == "text" {
                descLabel.text = descData.content
            }
        }
        
        //粉丝数
        if cellArray?.count > 3 {
            let fansData = cellArray![3]
            if fansData.type == "text" {
                fansLabel.text = fansData.content
            }
        }
        
        //点击手势
        let g = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        addGestureRecognizer(g)
        
    }
    
    //点击跳转
    func tapAction() {
        if cellArray?.count > 0 {
            let imageData = cellArray![0]
            if imageData.link != nil && jumpClosure != nil {
                jumpClosure!(imageData.link!)
            }
        }
    }
    
    //创建cell的方法
    class func createTalentCellFor(tableView: UITableView, atIndexPath indexPath: NSIndexPath,cellArray: Array<IngreRecommendWidgetData>) -> IngreTalnetCell {
        let cellId = "ingreTalnetCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? IngreTalnetCell
        if nil == cell {
            cell = NSBundle.mainBundle().loadNibNamed("IngreTalnetCell", owner: nil, options: nil).last as? IngreTalnetCell
        }
        //显示数据
        cell?.cellArray = cellArray
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
