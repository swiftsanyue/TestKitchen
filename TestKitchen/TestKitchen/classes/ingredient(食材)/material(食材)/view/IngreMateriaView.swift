//
//  IngreMateriaView.swift
//  TestKitchen
//
//  Created by qianfeng on 16/11/1.
//  Copyright © 2016年 zl. All rights reserved.
//

import UIKit

class IngreMateriaView: UIView {
    
    //点击事件
    var jumpClosure: IngreJumpClosure?
    
    //表格
    private var tbView:UITableView?
    
    //显示表格
    var model : IngreMaterial? {
        didSet{
            //刷新表格
            if model != nil {
                tbView?.reloadData()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //创建表格
        tbView = UITableView(frame: CGRectZero, style: .Plain)
        tbView?.delegate = self
        tbView?.dataSource = self
        addSubview(tbView!)
        
        //约束
        tbView?.snp_makeConstraints(closure: { (make) in
            make.edges.equalTo(self)
        })
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension IngreMateriaView:UITableViewDelegate,UITableViewDataSource{
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var row = 0
        if model?.data?.data?.count > 0 {
            row = (model?.data?.data?.count)!
        }
        return row
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        
        let tmpmodel = model?.data?.data![indexPath.row]

        return IngreMaterialCell.heightForCellWithModel(tmpmodel!)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellId = "IngreMaterialCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? IngreMaterialCell
        if nil == cell {
            cell = IngreMaterialCell(style: .Default, reuseIdentifier: cellId)
        }
        //显示数据
        cell?.cellModel = model?.data?.data![indexPath.row]
        
        //点击事件
        cell?.jumpClosure = jumpClosure
        
        //取消cell的点击
        cell?.selectionStyle = .None
        
        return cell!
    }
    
}

