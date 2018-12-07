#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'ftgsdk'
  s.version          = '0.0.1'
  s.summary          = 'TGSDK for Flutter'
  s.description      = <<-DESC
TGSDK for Flutter
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'TGSDK', '~> 1.8.2'

  s.ios.deployment_target = '8.0'
end

