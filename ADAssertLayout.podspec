Pod::Spec.new do |s|
  s.name             = 'ADAssertLayout'
  s.version          = '0.1.0'
  s.summary          = 'UIView helpers to make assertions on layout.'
  s.homepage         = 'https://github.com/applidium/ADAssertLayout'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = 'Pierre Felgines'
  s.source           = { :git => 'https://github.com/applidium/ADAssertLayout.git', :tag => s.version.to_s }
  s.swift_version = '4.2'
  s.ios.deployment_target = '9.0'
  s.source_files = 'ADAssertLayout/Classes/**/*'
  s.frameworks = 'UIKit'
end
