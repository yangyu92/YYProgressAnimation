//
//  YYGradualProgressView.swift
//  XFT315
//
//  Created by canyou on 16/9/3.
//  Copyright © 2016年 canyou. All rights reserved.
//

import UIKit

class YYGradualProgressView: UIView,CAAnimationDelegate{
    var viewWidth: CGFloat = 0
    
    var maskLayuer: CAGradientLayer?
    var progresst: CGFloat? = 0.0
    var colorArray: Array <AnyObject>?
    
    override var frame: CGRect {
        willSet {
            if frame.size.width == viewWidth {
                self.isHidden = true
            }
            super.frame = frame
            var maskRect = frame
            maskRect.origin.x = 0
            maskRect.origin.y = 0
            maskRect.size.width = self.bounds.width * progresst! + 0
            maskLayuer?.frame = maskRect
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //创建CAGradientLayer实例并设置参数
        maskLayuer = turquoiseColor()
        
        //设置其frame以及插入view的layer
        var maskRect = frame
        maskRect.origin.x = 0
        maskRect.origin.y = 0
        maskRect.size.width = self.bounds.width * progresst! + 0
        maskLayuer!.frame = maskRect
        self.isUserInteractionEnabled = false
        self.autoresizingMask = UIViewAutoresizing.flexibleWidth
        
//        self.layer.addSublayer(maskLayuer!)
        self.layer.insertSublayer(maskLayuer!, at: 0)
        gradinetAnimate()
    }
    
    func turquoiseColor() -> CAGradientLayer {
        let topColor = UIColor.red
        let bottomColor = UIColor.white
        
        colorArray = [topColor.cgColor, bottomColor.cgColor,topColor.cgColor]
        
        let gradientLocations: [CGFloat] = [0.0, 0.0001,0.0002]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: self.frame.size.height/(self.frame.size.width + 0))
        
        gradientLayer.colors = colorArray
        gradientLayer.locations = gradientLocations as [NSNumber]?
        return gradientLayer
    }
    
    func setProgress(_ value: CGFloat) {
        if progresst != value {
            progresst = min(1.0, fabs(value))
        }
        maskLayuer?.frame = setMaskRect(value)
    }
    
    func setMaskRect(_ progress: CGFloat) -> CGRect {
        
        var maskRect = self.maskLayuer?.frame
        maskRect!.size.width = (self.frame.size.width * progress)*2 + 0
        return maskRect!
    }
    
    func gradinetAnimate() {
        let gradient = CABasicAnimation(keyPath:"locations")
        
        gradient.fromValue = [-0.02,0,0.02]
        gradient.toValue = [0.98,1,1.02]
        gradient.duration = 4
        gradient.repeatCount = HUGE
        gradient.setValue("gradient", forKey: "gradient")
//        maskLayuer?.type = kCAGradientLayerAxial  像素均匀
        maskLayuer?.add(gradient, forKey: "colors")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startLoadProgressAnimation() {
        maskLayuer!.isHidden = false
        maskLayuer!.removeAllAnimations()
        
        gradinetAnimate()
        
        let animation = CABasicAnimation(keyPath: "bounds")
        animation.fromValue = NSValue(cgRect: setMaskRect(0.0))
        animation.toValue = NSValue(cgRect: setMaskRect(0.7))
//        animation.byValue = NSValue(CGRect: self.bounds)
        animation.duration = 3.0
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.repeatCount = 1
        animation.isRemovedOnCompletion = false
        animation.delegate = self
        
        animation.fillMode = kCAFillModeForwards
        animation.autoreverses = false       // 执行逆动画
        animation.setValue("animation1", forKey: "animation1")
        maskLayuer?.add(animation, forKey: "animation")
        
        let animation2 = CABasicAnimation(keyPath: "bounds")
        animation2.toValue = NSValue(cgRect: setMaskRect(0.9))
//        animation2.byValue = NSValue(CGRect: self.bounds)
        animation2.beginTime = CACurrentMediaTime() + animation.duration + animation.beginTime + 3.8
        animation2.duration = 2.0
        animation2.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation2.repeatCount = 1
//        animation.additive = true
        animation2.isRemovedOnCompletion = false
        animation2.delegate = self
        animation2.fillMode = kCAFillModeForwards
        animation2.autoreverses = false       // 执行逆动画
        animation2.setValue("animation2", forKey: "animation2")
        maskLayuer?.add(animation2, forKey: "animation2")
    }
    
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        if (((anim.value(forKey: "animation1") as AnyObject).isEqual("animation1"))) {
            if flag {
                //            print("动画1完成\(self.maskLayuer!.modelLayer().bounds.size.width)")
                print("动画1完成(正确结束)\(self.maskLayuer!.presentation()!.bounds.size.width)")
            }else {
                print("动画1完成(错误结束)\(maskLayuer!.bounds.size.width)")
                maskLayuer?.removeAnimation(forKey: "animation3")
                maskLayuer?.removeAnimation(forKey: "opacity1")
            }
            
        }
        if (((anim.value(forKey: "animation2") as AnyObject).isEqual("animation2"))) {
            
            if flag {
                //            print("动画1完成\(self.maskLayuer!.modelLayer().bounds.size.width)")
                print("动画2完成(正确结束)")
            }
            else {
                maskLayuer?.removeAnimation(forKey: "animation3")
                maskLayuer?.removeAnimation(forKey: "opacity1")
                print("动画2完成(错误结束)")
            }
            
        }
        if (((anim.value(forKey: "animation3") as AnyObject).isEqual("animation3"))) {
//            maskLayuer?.removeAnimationForKey("colors")
//            maskLayuer?.removeAnimationForKey("animation")
//            maskLayuer?.removeAnimationForKey("animation2")
//            maskLayuer?.removeAnimationForKey("animation3")
//            maskLayuer?.removeAnimationForKey("opacity1")
            
            if flag {
                maskLayuer!.removeAllAnimations()
                maskLayuer?.isHidden = true
                print("动画3完成(正确结束)")
            }
            else {
                maskLayuer?.removeAnimation(forKey: "opacity1")
                print("动画3完成(错误结束)")
            }
            
        }
        
    }
    
    func stopLoadProgressAnimation() {
        
        maskLayuer?.removeAnimation(forKey: "colors")
        
        let animation3 = CABasicAnimation(keyPath: "bounds")
        animation3.toValue = NSValue(cgRect: setMaskRect(1))
        animation3.duration = 0.3
        animation3.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation3.repeatCount = 1.0
        animation3.isRemovedOnCompletion = false
        animation3.delegate = self
        animation3.fillMode = kCAFillModeForwards
        animation3.autoreverses = false       // 执行逆动画
        animation3.setValue("animation3", forKey: "animation3")
        maskLayuer?.add(animation3, forKey: "animation3")
        
        let opaqueAnimate = CABasicAnimation(keyPath: "opacity")
        opaqueAnimate.fromValue = 1.0
        opaqueAnimate.toValue = 0.0
        opaqueAnimate.repeatCount = 1
        opaqueAnimate.duration = 0.5
        opaqueAnimate.isRemovedOnCompletion = false
        opaqueAnimate.delegate = self
        opaqueAnimate.fillMode = kCAFillModeForwards
        opaqueAnimate.autoreverses = false       // 执行逆动画
        maskLayuer?.add(opaqueAnimate, forKey: "opacity1")
        
////        let caa = maskLayuer?.animationForKey("animation")
//        maskLayuer!.removeAllAnimations()
////        maskLayuer?.removeAnimationForKey("animation")
////        maskLayuer?.removeAnimationForKey("animation2")
        
    }

}
