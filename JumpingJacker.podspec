#
# Be sure to run `pod lib lint JumpingJacker.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JumpingJacker'
  s.version          = '0.1.3'
  s.summary          = 'Jumping jack detector for ⌚️ (watchOS)'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Jumping jack detector for ⌚️ (watchOS).
                       DESC

  s.homepage         = 'https://github.com/nathanwchan/JumpingJacker'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Nathan Chan' => 'nchan87@gmail.com' }
  s.source           = { :git => 'https://github.com/nathanwchan/JumpingJacker.git', :tag => s.version.to_s }

  s.platform     = :watchos, '3.0'

  s.source_files = 'JumpingJacker/Classes/**/*'
  
  # s.resource_bundles = {
  #   'JumpingJacker' => ['JumpingJacker/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
