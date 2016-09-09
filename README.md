# YYProgressAnimation

[![Build Status](https://travis-ci.org/ninjaprox/NVActivityIndicatorView.svg?branch=master)](https://travis-ci.org/ninjaprox/NVActivityIndicatorView)
[![Cocoapods Compatible](https://img.shields.io/cocoapods/v/NVActivityIndicatorView.svg)](https://img.shields.io/cocoapods/v/NVActivityIndicatorView.svg)

# Introduction
YYProgressAnimation 用CABasicAnimation编写 swift版本中间亮色进度条,渐变消失

![alt tag](https://github.com/yangyu92/YYProgressAnimation/blob/master/YYProgressAnimationDemo/yyProgressAnimation.gif?raw=true)

# Used in Production


# Requirements
- iOS 8.0 or later
- ARC

# Usage
* 创建加载视图

```
override func viewWillAppear(animated: Bool) {
   loadProgress = YYGradualProgressView(frame: CGRect(x:0, y: self.navigationController!.navigationBar.frame.height, width: UIScreen.mainScreen().bounds.size.width, height: 3))
   self.navigationController!.navigationBar.addSubview(loadProgress!)
   super.viewWillAppear(animated)
}
```

- 启动加载动画

```
loadProgress?.startLoadProgressAnimation()   
```

* 加载完成

```
loadProgress!.stopLoadProgressAnimation()
```

* 退出时从父视图中移除

```
loadProgress!.removeFromSuperview()
```

# Install
## CocoaPods

```
 pod 'YYProgressAnimation', '~> 0.0.2'
```

# remark
==属于学习阶段,会自己完善功能,大神勿喷==

# License
[Apache]: http://www.apache.org/licenses/LICENSE-2.0
[MIT]: http://www.opensource.org/licenses/mit-license.php
[GPL]: http://www.gnu.org/licenses/gpl.html
[BSD]: http://opensource.org/licenses/bsd-license.php
[MIT license][MIT].


