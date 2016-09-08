//
//  ViewController.swift
//  YYProgressAnimationDemo
//
//  Created by canyou on 16/9/8.
//  Copyright © 2016年 com.yangyu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var loadProgressAnimationView: YYGradualProgressView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "颜色亮色渐变进度条"
    }
    
    @IBAction func SearchProgressAction(sender: AnyObject) {
        loadProgressAnimationView!.startLoadProgressAnimation()
    }
    
    @IBAction func RefreshProgressAction(sender: AnyObject) {
        loadProgressAnimationView!.stopLoadProgressAnimation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        loadProgressAnimationView = YYGradualProgressView(frame: CGRect(x:0, y: self.navigationController!.navigationBar.frame.height, width: UIScreen.mainScreen().bounds.size.width, height: 3))
        loadProgressAnimationView?.startLoadProgressAnimation()
        
        self.navigationController!.navigationBar.addSubview(loadProgressAnimationView!)
        
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        loadProgressAnimationView!.removeFromSuperview()
        super.viewWillDisappear(animated)
    }

}

