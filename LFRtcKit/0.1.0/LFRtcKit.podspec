#
# Be sure to run `pod lib lint LFRtcKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LFRtcKit'
  s.version          = '0.1.0'
  s.summary          = 'RtcKit of LiveFuller'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://codeup.teambition.com/5d009edc70f86b0001109ad2/common/ios/LivefullerDC'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'kerwin' => 'kerwin1232@163.com' }
  s.source           = { :git => 'https://codeup.teambition.com/5d009edc70f86b0001109ad2/common/ios/LivefullerDC.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'LFRtcKit/Classes/**/*'
  s.public_header_files = 'LFRtcKit/Classes/Header/*.h'
  # s.resource_bundles = {
  #   'LFRtcKit' => ['LFRtcKit/Assets/*.png']
  # }
  s.pod_target_xcconfig = { 'VALID_ARCHS' => 'x86_64 arm64 armv7 armv7s' }
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'AgoraRtcEngine_iOS', '~> 3.6.1'
  s.dependency 'AgoraRtm_iOS','~> 1.4.8'
end
