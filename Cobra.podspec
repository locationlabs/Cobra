Pod::Spec.new do |s|
  s.name                      = 'Cobra'
  s.module_name               = 'Cobra'
  s.version                   = '2.0.0'
  s.summary                   = 'Application routing framework written in Swift'
  s.description               = <<-DESC
Cobra is a lightweight application routing framework written in Swift that provides modular abstractions to your code base that is built on top of Swinject, a lightweight dependency injection framework.
                                DESC
  s.homepage                  = 'https://github.com/locationlabs/Cobra'
  s.license                   = 'APL2'
  s.author                    = { 'Location Labs' => 'iosswiftdevelop@locationlabs.com' }
  s.ios.deployment_target     = '8.0'
  s.requires_arc              = true
  s.source                    = { :git => 'https://github.com/locationlabs/Cobra.git', :tag => s.version }
  s.source_files              = 'Sources/**/*.{h,swift}'

  s.dependency 'Swinject', '~> 2.0.0-beta.2'
  s.dependency 'SwinjectPropertyLoader', '1.0.0-beta.2'
  s.subspec 'DataTypes' do |ss|
    ss.source_files           = 'Sources/Constructible.swift'
  end

end
