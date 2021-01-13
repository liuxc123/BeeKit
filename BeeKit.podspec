Pod::Spec.new do |s|
  s.name             = 'BeeKit'
  s.version          = '1.0.0'
  s.summary          = 'BeeKit 功能组件集合'
  s.homepage         = 'https://github.com/liuxc123/BeeKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liuxc123' => 'lxc_work@126.com' }
  s.source           = { :git => 'https://github.com/liuxc123/BeeKit.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.swift_version = '5.0'
  s.requires_arc = true

  s.subspec 'BeeCore' do |ss|
    ss.source_files = 'BeeModules/BeeCore/Source/**/*'
    ss.dependency 'CocoaLumberjack/Swift'
    ss.dependency 'SwifterSwift'
    ss.dependency 'MJRefresh'
    ss.dependency 'MBProgressHUD'
  end

  s.subspec 'BeeAppDelegate' do |ss|
    ss.source_files = 'BeeModules/BeeAppDelegate/Source/*.swift'
  end

  s.subspec 'BeeNavigator' do |ss|
    ss.source_files = 'BeeModules/BeeNavigator/Source/**/*.swift'
  end

  s.subspec 'BeeTheme' do |ss|
    ss.source_files = 'BeeModules/BeeTheme/Source/**/*.swift'
  end
  
  s.subspec 'BeeNavigationBar' do |ss|
    ss.source_files = 'BeeModules/BeeNavigationBar/Source/**/*'
    ss.dependency 'EachNavigationBar'
  end
  
  s.subspec 'BeePermission' do |ss|
    ss.source_files = 'BeeModules/BeePermission/Source/**/*'
  end

  s.subspec 'BeeAuto' do |ss|
    ss.source_files = 'BeeModules/BeeAuto/Source/**/*'
  end
  
  s.subspec 'BeeLimitInput' do |ss|
    ss.source_files = 'BeeModules/BeeLimitInput/Source/**/*'
    ss.dependency 'Smile'
  end
 
end
