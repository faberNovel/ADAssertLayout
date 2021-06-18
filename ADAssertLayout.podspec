Pod::Spec.new do |s|
  s.name             = 'ADAssertLayout'
  s.version          = '1.0.1'
  s.summary          = 'UIView helpers to make assertions on layout.'
  s.homepage         = 'https://github.com/faberNovel/ADAssertLayout'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = 'Pierre Felgines'
  s.source           = { :git => 'https://github.com/faberNovel/ADAssertLayout.git', :tag => "v#{s.version}" }
  s.swift_version = '5.1'
  s.ios.deployment_target = '9.0'
  s.tvos.deployment_target = '9.0'
  s.source_files = 'ADAssertLayout/Classes/**/*'
  s.frameworks = 'UIKit'
end
