#
# Be sure to run `pod lib lint BLoC.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name                  = 'BLoC'
  s.version               = '1.0.0'
  s.summary               = 'BLoC. A state management library'
  s.swift_versions        = '5.3'
  s.description           = 'Separates presentation from business logic. Ideal for testability and reusability.'
  s.homepage              = 'https://github.com/AnandSan/BLoC'
  s.license               = { :type => 'MIT', :file => 'LICENSE' }
  s.author                = { 'Anand Sankaran' => 'anand.sankaran.1979@gmail.com' }
  s.source                = { :git => 'https://github.com/AnandSan/BLoC.git', :tag => s.version.to_s }
  s.platform              = :ios, '13.0'
  s.ios.deployment_target = '13.0'
  s.source_files          = 'Sources/**/*'
end
