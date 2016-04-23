#
# Be sure to run `pod lib lint LctvSwift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "LctvSwift"
  s.version          = "0.8.0"
  s.summary          = "A framework for accessing Livecoding TV REST API."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
                        A framework for accessing Livecoding TV REST API. This library is currently
                        still under development, but it is already feature complete regarding the
                        current version of LivecodingTV API.
                       DESC

  s.homepage         = "https://github.com/tarrgor/LctvSwift"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "drswift" => "drswift@outlook.de" }
  s.source           = { :git => "https://github.com/tarrgor/LctvSwift.git", :tag => s.version.to_s }

  #s.platform     = :ios, '8.0'
  s.ios.deployment_target = '8.4'
  #s.tvos.deployment_target = '9.1'

  s.requires_arc = true

  s.source_files = 'Sources/**/*'
  # s.resource_bundles = {
  #   'LctvSwift' => ['Assets/*.png']
  # }

  # s.public_header_files = 'Sources/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Alamofire', '~> 3.0'
  s.dependency 'SwiftyJSON', '~> 2.3'
  s.dependency 'OAuthSwift', '~> 0.5.0'
  s.dependency 'Swifter', '~> 1.1.3'
  s.dependency 'Locksmith', '~> 2.0.8'
end
