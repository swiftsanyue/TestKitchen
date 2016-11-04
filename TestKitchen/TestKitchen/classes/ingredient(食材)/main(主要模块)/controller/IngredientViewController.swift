//
//  IngredientViewController.swift
//  TestKitchen
//
//  Created by qianfeng on 16/10/21.
//  Copyright © 2016年 zl. All rights reserved.
//

import UIKit

class IngredientViewController: BaseViewController {
    
    //滚动视图
    private var scrollView:UIScrollView?
    
    //推荐视图
    
    private var recommendView:IngreRecommendView?
    //食材视图
    private var materialView:IngreMateriaView?
    //分类视图
    private var categoryView:IngreMateriaView?
    
    //导航上面的选择控件
    private var segCtrl: KTCsegCtrl?
    
    var model = IngreRecommend()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //滚动视图或者其子视图放在导航下面，会自动加一个上面的间距，我们要取消这个间距
        automaticallyAdjustsScrollViewInsets = false
        //创建导航
        createNav()
        //创建首页视图
        createHomePage()
        //下载首页的推荐数据
        downloadRecommendData()
        //下载首页食材的数据
        downloadRecommendMaterial()
        //下载首页分类的数据
        downloadCategoryData()
    }
    
    //下载首页食材的数据
    func downloadRecommendMaterial(){
        
        //methodName=MaterialSubtype&token=&user_id=&version=4.32
        let dict = ["methodName":"MaterialSubtype"]
        let downloader = KTCDownloader()
        downloader.dalegate = self
        downloader.downloadType = .IngreMaterial
        downloader.postWithUrl(kHostUrl, params: dict)
        
    }
    
    //下载首页分类的数据
    func downloadCategoryData(){
        
        //methodName = CategoryIndex
        let dict = ["methodName":"CategoryIndex"]
        let downloader = KTCDownloader()
        downloader.dalegate = self
        downloader.downloadType = .IngreCategory
        downloader.postWithUrl(kHostUrl, params: dict)
    }
    
    //创建首页视图
    func createHomePage(){
        
        
        scrollView = UIScrollView()
        scrollView!.pagingEnabled = true
        //设置代理
        scrollView?.delegate = self
        
        view.addSubview(scrollView!)
                                                                                                                              
        //约束
        scrollView!.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(64, 0, 49, 0))
        }
  
        
        //容器视图
        let containerView = UIView.createView()
        scrollView!.addSubview(containerView)
        containerView.snp_makeConstraints { (make) in
            make.edges.equalTo(scrollView!)
            make.height.equalTo(scrollView!)
        }
        
        //添加子视图
        //1.推荐视图
        recommendView = IngreRecommendView()
        containerView.addSubview(recommendView!)
        recommendView?.snp_makeConstraints(closure: { (make) in
            make.top.bottom.left.equalTo(containerView)
            make.width.equalTo(KScreenW)
        })
        
        //2.食材视图
        materialView = IngreMateriaView()
        materialView?.backgroundColor = UIColor.purpleColor()
        containerView.addSubview(materialView!)
        materialView?.snp_makeConstraints(closure: { (make) in
            make.top.bottom.equalTo(containerView)
            make.width.equalTo(KScreenW)
            make.left.equalTo((recommendView?.snp_right)!)
        })
        //3.分类视图
        categoryView = IngreMateriaView()
        categoryView?.backgroundColor = UIColor.orangeColor()
        containerView.addSubview(categoryView!)
        categoryView?.snp_makeConstraints(closure: { (make) in
            make.top.bottom.equalTo(containerView)
            make.width.equalTo(KScreenW)
            make.left.equalTo((materialView?.snp_right)!)
        })
        
        //修改容器视图的大小
        containerView.snp_makeConstraints { (make) in
            make.right.equalTo(categoryView!)
        }
    }
    
    
    //创建导航
    func createNav(){
        //扫一扫
        addNavBtn("saoyisao", target: self, action: #selector(scanAction), isLeft: true)
        
        //搜索
        addNavBtn("search", target: self, action: #selector(searchAction), isLeft: false)
        
        //选择控件
        let frame = CGRectMake(80, 0, KScreenW-80*2, 44)
        segCtrl = KTCsegCtrl(frame: frame, titleArray: ["推荐","食材","分类"])
        segCtrl!.delegate = self
        navigationItem.titleView = segCtrl
    }
    
    //扫一扫
    func scanAction(){
        print("1")
    }
    func searchAction(){
        print("2")
    }
    
    //下载首页的推荐数据
    func downloadRecommendData(){
        //methodName=SceneHome&token=&user_id=&version=4.5
        let params = ["methodName":"SceneHome"]
        let downloader = KTCDownloader()
        downloader.dalegate = self
        downloader.downloadType = .IngreRecommend
        downloader.postWithUrl(kHostUrl, params: params)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//MARK: KTCDownloader 代理方法
extension IngredientViewController:KTCDownloaderDelegate {
    //下载失败
    func downloader(downloader: KTCDownloader, didFailWithError error: NSError) {
        print(error)
    }
    //下载成功
    func downloader(downloder: KTCDownloader, didFinishWithData data: NSData?) {
//        let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
//        print(str)
        if downloder.downloadType == .IngreRecommend {
            //推荐
            if let tmpData = data {
                //1.json解析
                let recommendModel = IngreRecommend.parseData(tmpData)
                //判断是否是主线程
                //        print(NSThread.currentThread())
                //2.显示UI
                recommendView!.model = recommendModel
                
                //            view.addSubview(recommendView!)
                //            self.model=recommendModel
                //3.点击食材的推荐页面的某一个部分，跳转到后面的界面的时候传值用的闭包
                recommendView!.jumpClosure = {
                    [weak self]
                    jumpUrl in
                    self!.handleClickEvent(jumpUrl)
                }
            }
        }else if downloder.downloadType == .IngreMaterial{
            //食材
//                    let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
//                    print(str)
            if let tmpData = data {
                let model = IngreMaterial.parseData(tmpData)
                materialView?.model = model
                
                //点击事件
                materialView?.jumpClosure = {
                    [weak self]
                    urlString in
                    self!.handleClickEvent(urlString)
                }
            }
            
        }else if downloder.downloadType == .IngreCategory{
            //分类
            //                    let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
            //                    print(str)
            if let tmpData = data {
                let model = IngreMaterial.parseData(tmpData)
                categoryView?.model = model
                
                //点击事件
                categoryView?.jumpClosure = {
                    [weak self]
                    urlString in
                    self!.handleClickEvent(urlString)
                }
            }
        }
    }
    
    
    //处理点击事件的方法
    func handleClickEvent(urlString:String) {
        print(urlString)
        IngreService.handleEvent(urlString, onViewController: self)
    }
    
}




//MARK: KTCSegCtrl代理
extension IngredientViewController:KTCsegCtrlDelegate{
    func segCtrl(segCtrl: KTCsegCtrl, didClickBtnAtIndex index: Int) {
        scrollView?.setContentOffset(CGPointMake(CGFloat(index)*KScreenW, 0), animated: true)
    }
}

//MARK:UIScrollView代理
extension IngredientViewController:UIScrollViewDelegate{
    //让导航条上的滑动视图在页面滚动的时候一起滚动
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x/scrollView.bounds.width
        segCtrl?.selectIndex = Int(index)
    }
}

