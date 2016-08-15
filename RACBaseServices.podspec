Pod::Spec.new do |s|
    s.name = 'RACBaseServices'
    s.version = '1.0.0'
    s.summary = 'A short description of RACBaseServices.'
    s.description = <<-DESC
    s.homepage = 'https://github.com/MarkeJave/RACBaseServices'
    s.license = 'MIT'
    s.author = { 'MarkeJave' => '308865427@qq.com' }
    s.source = { :git => 'https://github.com/MarkeJave/RACBaseServices.git', :tag => s.version.to_s }
    s.source_files = 'RACBaseServices/Services/*.{h,m}' 'RACBaseServices/ViewModel/*.{h,m}' 'RACBaseServices/Views/*.{h,m}' 'RACBaseServices/RACBaseServices.h'
    s.requires_arc = true
    s.frameworks ='Foundation'
    s.platform = :ios
    s.ios.deployment_target = '7.0'
    s.dependency 'ReactiveCocoa', '~> 4.2.1'
    s.private_header_files = 'RACBaseServices/Private/*.{h,m}'
end
