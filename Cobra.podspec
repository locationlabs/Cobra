Pod::Spec.new do |s|
  s.name                      = 'Cobra'
  s.module_name               = 'Cobra'
  s.version                   = '1.1.0'
  s.summary                   = 'Application routing framework written in Swift'
  s.homepage                  = 'http://www.locationlabs.com'
  s.license                   = 'APL2'
  s.author                    = { 'Location Labs' => 'iosswiftdevelop@locationlabs.com' }
  s.ios.deployment_target     = '8.0'
  s.requires_arc              = true
  s.source                    = { :git => 'https://github.com/locationlabs/Cobra.git', :tag => s.version }  
  s.source_files              = 'Sources/**/*.{h,swift}'

  s.dependency 'Swinject', '~> 1.1'

end
