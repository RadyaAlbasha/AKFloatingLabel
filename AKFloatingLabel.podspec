#
# Be sure to run `pod lib lint AKFloatingLabel.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AKFloatingLabel'
  s.version          = '1.0.0'
  s.summary          = 'Beautiful floating label pattern library. Written in Swift.'
  s.homepage         = 'https://github.com/dogo/AKFloatingLabel'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Diogo Autilio' => 'diautilio@gmail.com' }
  s.social_media_url = 'http://twitter.com/di_autilio'
  s.requires_arc     = true
  s.frameworks       = 'Foundation', 'UIKit'

  s.ios.deployment_target = '8.0'

  s.source           = { :git => 'https://github.com/dogo/AKFloatingLabel.git', :tag => s.version.to_s }
  s.source_files     = 'AKFloatingLabel/Classes/**/*'
end
