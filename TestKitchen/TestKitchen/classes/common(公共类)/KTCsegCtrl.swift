//
//  KTCsegCtrl.swift
//  TestKitchen
//
//  Created by ZL on 16/11/1.
//  Copyright © 2016年 zl. All rights reserved.
//

import UIKit

protocol KTCsegCtrlDelegate:NSObjectProtocol {
    
    //点击事件
    func segCtrl(segCtrl: KTCsegCtrl,didClickBtnAtIndex index: Int)
    
}

class KTCsegCtrl: UIView {
    
    //代理属性
    weak var delegate: KTCsegCtrlDelegate?
    
    //下划线图片
    private var lineView: UIImageView?
    
    //设置当前的序号
    var selectIndex: Int = 0 {
        didSet{
            if selectIndex != oldValue{
                //取消之前的选中状态
                let lastBtn = viewWithTag(300+oldValue)
                if lastBtn?.isKindOfClass(KTCSegBtn) == true {
                    let tmpBrn = lastBtn as! KTCSegBtn
                    tmpBrn.clicked = false
                }
                
                //选中当前点击的按钮
                let curBtn = viewWithTag(300+selectIndex)
                if lastBtn?.isKindOfClass(KTCSegBtn) == true {
                    let tmpBrn = curBtn as! KTCSegBtn
                    tmpBrn.clicked = true
                }
                UIView.animateWithDuration(0.25, animations: { 
                    //修改下滑线的位置
                    self.lineView?.frame.origin.x = (self.lineView?.frame.size.width)!*CGFloat(self.selectIndex)
                })
                
                
            }
        }
    }
    
    //重新实现初始化方法
    init(frame: CGRect,titleArray:Array<String>) {
        super.init(frame: frame)
        
        //创建按钮
        if titleArray.count > 0{
            createBtns(titleArray)
        }
        
        
        
        
    }
    
    //创建按钮的方法
    func createBtns(titleArray:Array<String>){
        
        //按钮宽度
        let w = bounds.size.width/CGFloat(titleArray.count)
        for i in 0..<titleArray.count{
            //循环创建按钮
            let frame = CGRectMake(w*CGFloat(i), 0, w, bounds.size.height)
            let btn = KTCSegBtn(frame: frame)
            //默认选中第一个
            if i == 0 {
                btn.clicked = true
            }else{
                btn.clicked = false
            }
            
            btn.config(titleArray[i])
            
            
            
            //添加点击事件
            btn.tag = 300+i
            btn.addTarget(self, action: #selector(clickBtn(_:)), forControlEvents: .TouchUpInside)
            
            addSubview(btn)
        }
        //下滑线
        lineView = UIImageView(frame: CGRectMake(0, bounds.size.height-2, w, 2))
        lineView?.backgroundColor = UIColor.redColor()
//        lineView?.image = UIImage(named: "navBtn_bag")
        addSubview(lineView!)
        
    }
    func clickBtn(btn:KTCSegBtn){
        let index = btn.tag-300
        //修改选中的UI
        selectIndex = index
        delegate?.segCtrl(self, didClickBtnAtIndex: index)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



//自定制按钮
class KTCSegBtn:UIControl {
    
    private var titleLabel: UILabel?
    
    //设置选中状态
    var clicked: Bool = false{
        didSet{
            if clicked == true{
                //选中
                titleLabel?.textColor = UIColor.blackColor()
            }else{
                //取消选中
                titleLabel?.textColor = UIColor.lightGrayColor()
            }
        }
    }
    
    //显示数据
    func config(title:String?){
        titleLabel?.text = title
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel = UILabel.createLabel(nil, textAlignment: .Center, font: UIFont.systemFontOfSize(20))
        titleLabel?.frame = bounds
        addSubview(titleLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}






