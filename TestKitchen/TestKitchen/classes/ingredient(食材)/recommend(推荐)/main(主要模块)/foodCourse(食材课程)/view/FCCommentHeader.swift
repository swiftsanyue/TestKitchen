//
//  FCCommentHeader.swift
//  TestKitchen
//
//  Created by ZL on 16/11/4.
//  Copyright © 2016年 zl. All rights reserved.
//

import UIKit

class FCCommentHeader: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    
    func config(num: String) {
        titleLabel.text = "\(num)条评论"
    }
    
    @IBAction func commentAction(sender: UIButton) {
        
    }

}
