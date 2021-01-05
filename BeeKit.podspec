Pod::Spec.new do |s|
  s.name             = 'BeeKit'
  s.version          = '1.0.0'
  s.summary          = 'A short description of BeeKit.'
  s.description      = <<-DESC
  TODO：iOS项目开发通用&非通用型模块代码，多功能组件，可快速集成使用以大幅减少基础工作量；便利性扩展&链式扩展
                       DESC

  s.homepage         = 'https://github.com/liuxc123/BeeKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liuxc123' => 'lxc_work@126.com' }
  s.source           = { :git => 'https://github.com/liuxc123/BeeKit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.swift_version = ['5.0', '5.1', '5.3']
  # s.default_subspec = 'Core'

  s.subspec 'BeeCore' do |ss|
    ss.source_files = 'BeeModules/BeeCore/Source/*.swift'
    ss.dependency 'BeeKit/BeeExtension'
    ss.dependency 'BeeKit/BeeAppDelegate'
    ss.dependency 'BeeKit/BeeNavigator'
    ss.dependency 'BeeKit/BeeLog'
    ss.dependency 'Device'
    ss.dependency 'SnapKit'
  end

  s.subspec 'BeeExtension' do |ss|
    ss.source_files = 'BeeModules/BeeExtension/Source/**/*'
    ss.dependency 'BeeKit/BeeCompatible'
    ss.dependency 'SwifterSwift'
    ss.dependency 'RxSwift', '>= 5.0.0'
    ss.dependency 'RxCocoa', '>= 5.0.0'
  end
  
  s.subspec 'BeeCompatible' do |ss|
    ss.source_files = 'BeeModules/BeeCompatible/Source/*.swift'
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
  
  s.subspec 'BeeLog' do |ss|
    ss.source_files = 'BeeModules/BeeLog/Source/**/*.swift'
    ss.dependency 'CocoaLumberjack/Swift'
  end

  s.subspec 'BeeTable' do |ss|
    ss.source_files = 'BeeModules/BeeTable/Source/**/*'
  end
  
  s.subspec 'BeeForm' do |ss|
    ss.source_files = 'BeeModules/BeeForm/Source/**/*'
  end
  
  s.subspec 'BeeNavigationBar' do |ss|
    ss.source_files = 'BeeModules/BeeNavigationBar/Source/**/*'
    ss.dependency 'EachNavigationBar'
  end

  s.subspec 'BeeRefresh' do |ss|
    ss.source_files = 'BeeModules/BeeRefresh/Source/**/*'
    ss.dependency 'BeeKit/BeeExtension'
    ss.dependency 'MJRefresh'
  end

  s.subspec 'BeeNetwork' do |ss|
    ss.source_files = 'BeeModules/BeeNetwork/Source/**/*'
    ss.dependency 'BeeKit/BeeExtension'
    ss.dependency 'Moya'
    ss.dependency 'SwiftyJSON'
    ss.dependency 'ObjectMapper'
  end

  s.subspec 'BeePermission' do |ss|
    ss.source_files = 'BeeModules/BeePermission/Source/**/*'
    ss.dependency 'BeeKit/BeeExtension'
    ss.dependency 'Moya'
    ss.dependency 'SwiftyJSON'
    ss.dependency 'ObjectMapper'
  end

  s.subspec 'BeeAuto' do |ss|
    ss.source_files = 'BeeModules/BeeAuto/Source/**/*'
  end
  
  s.subspec 'BeeLimitInput' do |ss|
    ss.source_files = 'BeeModules/BeeLimitInput/Source/**/*'
    ss.dependency 'Smile'
  end
 
end
