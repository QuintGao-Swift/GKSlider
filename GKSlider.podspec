Pod::Spec.new do |s|
  s.name             = 'GKSlider'
  s.version          = '1.0.2'
  s.summary          = 'GKSlider - iOS自定义滑杆、进度条控件'
  s.description      = <<-DESC
一个自定义的滑杆、进度条控件，可替代系统的UISlider、UIProgressView，实现对应的功能
                       DESC
  s.homepage         = 'https://github.com/QuintGao-Swift/GKSlider'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'QuintGao' => '1094887059@qq.com' }
  s.source           = { :git => 'https://github.com/QuintGao-Swift/GKSlider.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.source_files = 'GKSlider/**/*'
  s.swift_version = '5.0'
  s.requires_arc  = true
end
