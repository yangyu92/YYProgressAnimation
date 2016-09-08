//
//  YYGradualProgressView.swift
//  XFT315
//
//  Created by canyou on 16/9/3.
//  Copyright © 2016年 canyou. All rights reserved.
//

import UIKit

class YYGradualProgressView: UIView {
    var viewWidth: CGFloat = 0
    
    var maskLayuer: CAGradientLayer?
    var progresst: CGFloat? = 0.0
    var colorArray: Array <AnyObject>?
    
    override var frame: CGRect {
        willSet {
            if frame.size.width == viewWidth {
                self.hidden = true
            }
            super.frame = frame
            var maskRect = frame
            maskRect.origin.x = -200
            maskRect.origin.y = 0
            maskRect.size.width = CGRectGetWidth(self.bounds) * progresst! + 200
            maskLayuer?.frame = maskRect
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //创建CAGradientLayer实例并设置参数
        maskLayuer = turquoiseColor()
        
        //设置其frame以及插入view的layer
        var maskRect = frame
        maskRect.origin.x = -200
        maskRect.origin.y = 0
        maskRect.size.width = CGRectGetWidth(self.bounds) * progresst! + 200
        maskLayuer!.frame = maskRect
        self.userInteractionEnabled = false
        self.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        
//        self.layer.addSublayer(maskLayuer!)
        self.layer.insertSublayer(maskLayuer!, atIndex: 0)
        gradinetAnimate()
    }
    
    func turquoiseColor() -> CAGradientLayer {
        let topColor = UIColor.redColor()
        let bottomColor = UIColor.whiteColor()
        
        colorArray = [topColor.CGColor, bottomColor.CGColor,topColor.CGColor]
        
        let gradientLocations: [CGFloat] = [0.0, 0.0001,0.0002]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPointMake(0.0, 0.0)
        gradientLayer.endPoint = CGPointMake(1.0, self.frame.size.height/(self.frame.size.width + 200))
        
        gradientLayer.colors = colorArray
        gradientLayer.locations = gradientLocations
        return gradientLayer
    }
    
    func setProgress(value: CGFloat) {
        if progresst != value {
            progresst = min(1.0, fabs(value))
        }
        maskLayuer?.frame = setMaskRect(value)
    }
    
    func setMaskRect(progress: CGFloat) -> CGRect {
        
        var maskRect = self.maskLayuer?.frame
        maskRect!.size.width = (self.frame.size.width * progress)*2 + 200
        return maskRect!
    }
    
    func gradinetAnimate() {
        let gradient = CABasicAnimation(keyPath:"locations")
        
        gradient.fromValue = [-0.02,0,0.02]
        gradient.toValue = [0.98,1,1.02]
        gradient.duration = 4
        gradient.repeatCount = HUGE
//        maskLayuer?.type = kCAGradientLayerAxial  像素均匀
        maskLayuer?.addAnimation(gradient, forKey: "colors")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startLoadProgressAnimation() {
        maskLayuer!.hidden = false
        maskLayuer!.removeAllAnimations()
        
        gradinetAnimate()
        
        let animation = CABasicAnimation(keyPath: "bounds")
        animation.fromValue = NSValue(CGRect: setMaskRect(0.0))
        animation.toValue = NSValue(CGRect: setMaskRect(0.7))
//        animation.byValue = NSValue(CGRect: self.bounds)
        animation.duration = 3.0
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.repeatCount = 1
        animation.removedOnCompletion = false
        animation.delegate = self
        animation.fillMode = kCAFillModeForwards
        animation.autoreverses = false       // 执行逆动画
        animation.setValue("animation1", forKey: "animation1")
        maskLayuer?.addAnimation(animation, forKey: "animation")
        
        let animation2 = CABasicAnimation(keyPath: "bounds")
        animation2.toValue = NSValue(CGRect: setMaskRect(0.9))
//        animation2.byValue = NSValue(CGRect: self.bounds)
        animation2.beginTime = CACurrentMediaTime() + animation.duration + animation.beginTime + 2.8
        animation2.duration = 2.0
        animation2.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation2.repeatCount = 1
//        animation.additive = true
        animation2.removedOnCompletion = false
        animation2.delegate = self
        animation2.fillMode = kCAFillModeForwards
        animation2.autoreverses = false       // 执行逆动画
        animation2.setValue("animation2", forKey: "animation2")
        maskLayuer?.addAnimation(animation2, forKey: "animation2")
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if ((anim.valueForKey("animation1")?.isEqual("animation1")) != nil) {
            if flag {
                //            print("动画1完成\(self.maskLayuer!.modelLayer().bounds.size.width)")
                print("动画1完成(正确结束)\(self.maskLayuer!.presentationLayer()!.bounds.size.width)")
            }else {
                print("动画1完成(错误结束)\(maskLayuer!.bounds.size.width)")
                maskLayuer?.removeAnimationForKey("animation3")
                maskLayuer?.removeAnimationForKey("opacity1")
            }
            
        }
        if ((anim.valueForKey("animation2")?.isEqual("animation2")) != nil) {
            
            if flag {
                //            print("动画1完成\(self.maskLayuer!.modelLayer().bounds.size.width)")
                print("动画2完成(正确结束)")
            }
            else {
                maskLayuer?.removeAnimationForKey("animation3")
                maskLayuer?.removeAnimationForKey("opacity1")
                print("动画2完成(错误结束)")
            }
            
        }
        if ((anim.valueForKey("animation3")?.isEqual("animation3")) != nil) {
//            maskLayuer?.removeAnimationForKey("colors")
//            maskLayuer?.removeAnimationForKey("animation")
//            maskLayuer?.removeAnimationForKey("animation2")
//            maskLayuer?.removeAnimationForKey("animation3")
//            maskLayuer?.removeAnimationForKey("opacity1")
            
            if flag {
                maskLayuer!.removeAllAnimations()
                maskLayuer?.hidden = true
                print("动画3完成(正确结束)")
            }
            else {
                maskLayuer?.removeAnimationForKey("opacity1")
                print("动画3完成(错误结束)")
            }
            
        }
        
    }
    
    func stopLoadProgressAnimation() {
        
        let animation3 = CABasicAnimation(keyPath: "bounds")
        animation3.toValue = NSValue(CGRect: setMaskRect(1))
        animation3.duration = 1.0
        animation3.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation3.repeatCount = 1.0
        animation3.removedOnCompletion = false
        animation3.delegate = self
        animation3.fillMode = kCAFillModeForwards
        animation3.autoreverses = false       // 执行逆动画
        animation3.setValue("animation3", forKey: "animation3")
        maskLayuer?.addAnimation(animation3, forKey: "animation3")
        
        let opaqueAnimate = CABasicAnimation(keyPath: "opacity")
        opaqueAnimate.fromValue = 1.0
        opaqueAnimate.toValue = 0.0
        opaqueAnimate.repeatCount = 1
        opaqueAnimate.duration = 1.5
        opaqueAnimate.removedOnCompletion = false
        opaqueAnimate.delegate = self
        opaqueAnimate.fillMode = kCAFillModeForwards
        opaqueAnimate.autoreverses = false       // 执行逆动画
        maskLayuer?.addAnimation(opaqueAnimate, forKey: "opacity1")
        
////        let caa = maskLayuer?.animationForKey("animation")
//        maskLayuer!.removeAllAnimations()
////        maskLayuer?.removeAnimationForKey("animation")
////        maskLayuer?.removeAnimationForKey("animation2")
        
    }

    func endLoadProgressAnimation() {
        weak var tmpSelf = self
        
        UIView.animateWithDuration(3, animations: { () -> Void in
            self.setProgress(1.0)
        }) { (finish) -> Void in
            tmpSelf!.hidden = true
        }
    }
}
