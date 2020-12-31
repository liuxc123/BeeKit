Pod::Spec.new do |s|
  s.name             = 'BeeKit'
  s.version          = '1.0.0'
  s.summary          = 'A short description of BeeKit.'
  s.description      = <<-DESC
  TODO：iOS项目开发通用&非通用型模块代码，多功能组件，可快速集成使用以大幅减少基础工作量；便利性扩展&链式扩展、UI排班组件Form、正则表达式扩展RegEx、计时器管理Timer、简易提示窗HUD、AppDelegate解耦方案、分页控制Page、自定义导航栏TopBar、阿里矢量图标管理IconFonts、MJRefresh扩展、Alamofire扩展......
  附.各种类库使用示例demo.
                       DESC

  s.homepage         = 'https://github.com/liuxc123/BeeKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liuxc123' => 'lxc_work@126.com' }
  s.source           = { :git => 'https://github.com/liuxc123/BeeKit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.swift_version = ['5.0', '5.1', '5.3']
  # s.default_subspec = 'Core'

  s.subspec 'Core' do |ss|
    ss.source_files = 'BeeModules/BeeCore/Source/*.swift'
    ss.dependency 'BeeKit/Extension'
    ss.dependency 'BeeKit/Compatible'
    ss.dependency 'BeeKit/Compatible'
    ss.dependency 'BeeKit/AppDelegate'
    ss.dependency 'BeeKit/Navigator'
  end


  s.subspec 'Extension' do |ss|
    ss.source_files = 'BeeModules/BeeExtension/Source/*.swift'
    ss.dependency 'SwifterSwift'
#    ss.dependency 'SwiftyAttributes'
    ss.dependency 'Device'
  end

  s.subspec 'Compatible' do |ss|
    ss.source_files = 'BeeModules/BeeCompatible/Source/*.swift'
  end

  s.subspec 'AppDelegate' do |ss|
    ss.source_files = 'BeeModules/BeeAppDelegate/Source/*.swift'
  end

  s.subspec 'Navigator' do |ss|
    ss.source_files = 'BeeModules/BeeNavigator/Source/**/*.swift'
  end

  s.subspec 'Theme' do |ss|
    ss.source_files = 'BeeModules/BeeTheme/Source/**/*.swift'
  end

#  s.subspec 'Form' do |ss|
#    ss.source_files = 'BeeModules/BeeForm/Source/*.{h}'
#    ss.dependency 'TableKit'
#    ss.dependency 'FormKit'
#  end
 
end
