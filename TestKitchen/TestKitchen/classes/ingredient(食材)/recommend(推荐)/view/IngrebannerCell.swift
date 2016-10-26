//
//  IngrebannerCell.swift
//  TestKitchen
//
//  Created by qianfeng on 16/10/25.
//  Copyright © 2016年 zl. All rights reserved.
//

import UIKit

class IngreBannerCell: UITableViewCell {
    
    //闭包,由主页一步步传过来的
    var jumpClosure:(String->Void)?

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageCtrl: UIPageControl!
    
    //显示数据
    var bannerArray:Array<IngreRecommendBanner>?{
        didSet{
            //显示数据
            showData()
        }
    }
    //显示数据
    private func showData(){
        //遍历图片
        let cnt = bannerArray!.count
        if bannerArray?.count > 0 {
            
            //滚动视图加约束
            //1.创建一个容器视图,作为滚动视图的子视图
            let containerView = UIView.createView()
            scrollView.addSubview(containerView)
            containerView.snp_makeConstraints(closure: { (make) in
                make.edges.equalTo(scrollView)
                //一定要设置高度
                make.height.equalTo(scrollView)
            })
            //2.循环设置子视图的约束,子视图是添加到容器视图里面
            var lastView: UIView? = nil
            
            
            
            for i in 0..<cnt {
                let model = bannerArray![i]
                //创建图片
                let tmpImageView = UIImageView()
                let url = NSURL(string: model.banner_picture!)
                tmpImageView.kf_setImageWithURL(url!, placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                containerView.addSubview(tmpImageView)
                
                //添加点击事件
                tmpImageView.userInteractionEnabled=true
                tmpImageView.tag = 200+i
                let g = UITapGestureRecognizer(target: self, action: #selector(tapImage(_:)))
                tmpImageView.addGestureRecognizer(g)
                
                //图片的约束
                tmpImageView.snp_makeConstraints(closure: { (make) in
                    make.top.bottom.equalTo(containerView)
                    make.width.equalTo(scrollView)
                    if lastView == nil {
                        make.left.equalTo(containerView)
                    }else{
                        make.left.equalTo((lastView?.snp_right)!)
                    }
                })
                
                lastView = tmpImageView
            }
            //3.修改container的宽度
            containerView.snp_makeConstraints(closure: { (make) in
                make.right.equalTo(lastView!)
            })
            //4.分页控件
            pageCtrl.numberOfPages = cnt
        }
    }
    //用父类的指针指向
    func tapImage(g:UIGestureRecognizer) {
        let index = (g.view?.tag)!-200
        //获取点击的数据
        let banner = bannerArray![index]
        if jumpClosure != nil && banner.banner_link != nil {
            jumpClosure!(banner.banner_link!)
        }
    }
    
    //创建cell的方法
    class func createBannerCellFor(tableView:UITableView,atIndexPath indexPath:NSIndexPath,bannerArray:Array<IngreRecommendBanner>?) -> IngreBannerCell{
        //重用标志
        let cellId = "ingreBannerCellId"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? IngreBannerCell
        if nil == cell {
            //IngreBannerCell.xib
            cell = NSBundle.mainBundle().loadNibNamed("IngreBannerCell", owner: nil, options: nil).last as? IngreBannerCell
        }
        //显示数据
        cell?.bannerArray = bannerArray
        return cell!
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//MARK: UIScrollView 代理
extension IngreBannerCell:UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let index = scrollView.contentOffset.x/scrollView.bounds.size.width
        pageCtrl.currentPage = Int(index)
    }
    
}










