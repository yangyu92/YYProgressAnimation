Pod::Spec.new do |s|
  s.name         = "YYProgressAnimation"
  s.version      = "0.0.1"
  s.summary      = "Gradient effect The progress bar animation"
  s.homepage     = "http://github.com/yangyu92/YYProgressAnimation"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "yangyu" => "yang_yu92@foxmail.com" }
  # s.platform     = :ios
  # s.platform     = :ios, "5.0"
  s.ios.deployment_target = "8.0"
  s.tvos.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/yangyu92/YYProgressAnimation.git", :tag => "#{s.version}" }
  s.source_files  = "YYProgressAnimation/*.swift"
  # s.exclude_files = "Classes/github.com/yangyu92/YYProgressAnimation"
  # s.public_header_files = "YYProgressAnimation/*.swift"
  s.requires_arc = true
  s.frameworks = "UIKit"

end
