#
# Be sure to run `pod lib lint LJTimerBlockManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LJRepeatsBlockTimer'
  s.version          = '0.1.0'
  s.summary          = 'Manage multiple timer task, so user (mostly ViewControllers) do care about setting timmer.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                       A simple class manage multiple timer task, so user (mostly ViewControllers) do care about setting timmer.
                       DESC

  s.homepage         = 'https://github.com/lanjing99/LJRepeatsBlockTimer'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lanjing' => '84336951@qq.com' }
  s.source           = { :git => 'https://github.com/lanjing99/LJRepeatsBlockTimer', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '7.0'

  s.source_files = 'LJRepeatsBlockTimer/Classes/**/*'
  
  # s.resource_bundles = {
  #   'LJRepeatsBlockTimer' => ['LJTimerBlockManager/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
