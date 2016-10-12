# Cobra
Cobra is a lightweight application routing framework written in Swift that provides modular abstractions
to your code base that is built on top of [Swinject][1], a lightweight dependency injection
framework.

## Features
- [X] Type safe application routing via features
- [X] Multiple flavor (e.g. environments) support for different components
- [X] Proxy powered routing for easy A/B testing of features
- [X] Foundation for modular code architecture

Cobra works best when used with [Medusa][2], an application event distribution framework written in 
Swift and [Moccasin][3], Xcode templates that provides a variation of [VIPER][4] architecture for 
iOS applications.

See [Boa][5], a sample app written in Swift, for details.

## Requirements
- iOS8+
- Xcode 7.3+

## Installation
Cobra is available through [CocoaPods](https://cocoapods.org).

### CocoaPods

To install Cobra with CocoaPods, add the following lines to your `Podfile`.

    source 'https://github.com/CocoaPods/Specs.git'
    platform :ios, '8.0'
    use_frameworks!

    pod 'Cobra', '~> 1.0'

Then run `pod install` command. For details of the installation and usage of CocoaPods, visit [its official website](https://cocoapods.org).

## Documentation
WIP

## TODO
This is the initial port of an internal framework developed at [Location Labs][6] for building
modular iOS applications. Be it that this library used to be used internally there are things
that haven't been implemented yet...

- [ ] Documentation
- [ ] More unit tests
- [ ] Travis CI integration
- [ ] Ensure Carthage support
- [ ] Swift Package Manager support
- [ ] TvOS, WatchOS, MacOS support
- [ ] Swiftlint support
- [ ] Provide contribution guidelines


[1]: https://github.com/Swinject/Swinject
[2]: https://github.com/locationlabs/Medusa
[3]: https://github.com/locationlabs/Moccasin
[4]: http://mutualmobile.github.io/blog/2013/12/04/viper-introduction/
[5]: https://github.com/locationlabs/Boa
[6]: http://www.locationlabs.com/
