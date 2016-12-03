//
//  FCVideoCell.swift
//  TestKitchen
//
//  Created by ZL on 16/11/4.
//  Copyright © 2016年 zl. All rights reserved.
//

import UIKit

class FCVideoCell: UITableViewCell {
    
    //播放视频
    var playClosure:(String-> Void)?
    
    //显示数据
    var cellModel: FoodCourseSerial? {
        didSet{
            if cellModel != nil {
            showData()
            }
        }
    }
    
    func showData() {
        //图片
        let url = NSURL(string: (cellModel?.course_image)!)
        bgImgeView.kf_setImageWithURL(url, placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
        //文字
        numLabel.text = "\(cellModel!.video_watchcount!)人做过"
        numLabel.textColor = UIColor.whiteColor()
        
        
    }
    

    @IBOutlet weak var bgImgeView: UIImageView!
    
    @IBOutlet weak var numLabel: UILabel!
    
    @IBAction func playBtn(sender: UIButton) {
        
        if cellModel?.course_video != nil && playClosure != nil {
            playClosure!((cellModel?.course_video)!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
