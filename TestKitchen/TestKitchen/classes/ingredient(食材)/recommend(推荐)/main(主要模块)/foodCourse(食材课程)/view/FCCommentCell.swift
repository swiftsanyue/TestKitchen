//
//  FCCommentCell.swift
//  TestKitchen
//
//  Created by ZL on 16/11/4.
//  Copyright © 2016年 zl. All rights reserved.
//

import UIKit

class FCCommentCell: UITableViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    //显示数据
    var model: FoodCourseCommentDatail? {
        didSet{
            if model != nil {
                //图片
                let url = NSURL(string: (model?.head_img)!)
                userImageView.kf_setImageWithURL(url, placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                userImageView.layer.cornerRadius = 30
                userImageView.layer.masksToBounds = true
                
                //名字
                userNameLabel.text = model?.nick
                //评论内容
                descLabel.text = model?.content
                descLabel.textColor = UIColor.grayColor()
                //评论时间
                timeLabel.text = model?.create_time
                timeLabel.textColor = UIColor.grayColor()
            }
        }
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
