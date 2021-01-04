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
  end

  s.subspec 'BeeExtension' do |ss|
    ss.source_files = 'BeeModules/BeeExtension/Source/**/*.swift'
    ss.dependency 'BeeKit/BeeCompatible'
    ss.dependency 'SwifterSwift'
#    ss.dependency 'SwiftyAttributes'
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
  
  s.subspec 'BeeRefresh' do |ss|
    ss.source_files = 'BeeModules/BeeRefresh/Source/**/*'
    ss.dependency 'BeeKit/BeeExtension'
    ss.dependency 'MJRefresh'
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
  
 
end
