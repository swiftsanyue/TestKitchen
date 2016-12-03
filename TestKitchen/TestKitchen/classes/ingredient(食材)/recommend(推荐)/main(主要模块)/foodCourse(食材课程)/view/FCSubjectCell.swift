//
//  FCSubjectCell.swift
//  TestKitchen
//
//  Created by ZL on 16/11/4.
//  Copyright © 2016年 zl. All rights reserved.
//

import UIKit

class FCSubjectCell: UITableViewCell {
    
    //显示数据
    var cellModel: FoodCourseSerial? {
        didSet {
            
            if cellModel != nil {
                showData()
            }
        }
    }
    
    func showData(){
        
        titleLabel.text = cellModel?.course_name
        
        descLabel.text = cellModel?.course_subject
        descLabel.textColor = UIColor.grayColor()
        
    }
    
    //计算cell的高度
    class func heightForSubjectCell(model:FoodCourseSerial)->CGFloat{
        let h = 10+20+10
        let str=NSString(string: model.course_subject!)
        let attr=[NSFontAttributeName:UIFont.systemFontOfSize(17)]
        let subjectH=str.boundingRectWithSize(CGSizeMake(KScreenW-20*2, CGFloat.max), options: .UsesLineFragmentOrigin, attributes: attr, context: nil).size.height
        
        return CGFloat(h)+10+subjectH+10
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
