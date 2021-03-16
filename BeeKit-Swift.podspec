Pod::Spec.new do |s|
  s.name             = 'BeeKit-Swift'
  s.version          = '1.0.1'
  s.summary          = 'BeeKit 功能组件集合'
  s.homepage         = 'https://github.com/liuxc123/BeeKit-Swift'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liuxc123' => 'lxc_work@126.com' }
  s.source           = { :git => 'https://github.com/liuxc123/BeeKit.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.swift_version = '5.0'
  s.requires_arc = true
  s.frameworks = 'UIKit', 'Foundation'

  s.subspec 'Base' do |ss|
    ss.source_files = 'Components/Base/Source/**/*'
    ss.resources = 'Components/Base/Assets/**/*'
    ss.dependency 'CocoaLumberjack/Swift'
    ss.dependency 'SwifterSwift'
    ss.dependency 'SwiftValidators'
    ss.dependency 'SwiftyAttributes'
    ss.dependency 'MJRefresh'
    ss.dependency 'MBProgressHUD'
  end

  s.subspec 'AppDelegate' do |ss|
    ss.source_files = 'Components/AppDelegate/Source/*.swift'
  end

  s.subspec 'Auto' do |ss|
    ss.source_files = 'Components/Auto/Source/**/*'
  end

  s.subspec 'Navigator' do |ss|
    ss.source_files = 'Components/Navigator/Source/**/*.swift'
  end

  s.subspec 'NavigationBar' do |ss|
    ss.source_files = 'Components/NavigationBar/Source/**/*'
    ss.dependency 'BeeKit-Swift/Base'
    ss.dependency 'EachNavigationBar'
  end

  s.subspec 'Theme' do |ss|
    ss.source_files = 'Components/Theme/Source/**/*.swift'
  end

  s.subspec 'LimitInput' do |ss|
    ss.source_files = 'Components/LimitInput/Source/**/*'
    ss.dependency 'BeeKit-Swift/Base'
    ss.dependency 'Smile'
  end
end
