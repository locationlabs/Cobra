source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '8.0'

# flag makes all dependencies build as frameworks
use_frameworks!

abstract_target 'CobraBase' do

   # framework dependencies
   pod 'Swinject', '~> 2.0.0-beta.2'
   pod 'SwinjectPropertyLoader', '1.0.0-beta.2'

   
   target 'Cobra' do
   end

   # test specific dependencies
   target 'CobraTests' do
      pod 'Quick'
      pod 'Nimble'
   end
end


