# Cobra

[![Build Status](https://travis-ci.org/locationlabs/Cobra.svg?branch=master)](https://travis-ci.org/locationlabs/Cobra)

Cobra is a lightweight application routing framework written in Swift that provides modular abstractions to your code base. Cobra is built on top of [Swinject][1], a lightweight dependency injection framework.

## Features
- [X] Type safe application routing via features
- [X] Multiple flavor (e.g. environments) support for different components
- [X] Proxy powered routing for easy A/B testing of features
- [X] Foundation for modular code architecture

Cobra works best when used with [Gorgon][2], an application event distribution framework written in Swift, and [Moccasin][3], Xcode templates that provides [VIPER][4]-based scaffolding.

See [Boa][5], a sample app written in Swift, for details.

## Requirements
- iOS 8+
- Swift 3
- Xcode 8.0+


## Installation
Cobra is available through [CocoaPods](https://cocoapods.org) or [Carthage](https://github.com/Carthage/Carthage).

### CocoaPods

To install Cobra with CocoaPods, add the following lines to your `Podfile`.

    source 'https://github.com/CocoaPods/Specs.git'
    platform :ios, '8.0'
    use_frameworks!

    pod 'Cobra', '~> 3.0'

Then run `pod install` command. For details of the installation and usage of CocoaPods, visit [its official website](https://cocoapods.org).

### Carthage

To install Cobra with Carthage, add the following line to your `Cartfile`.

```
github "locationlabs/Cobra" ~> 3.0
```

Then run `carthage update`. For details of the installation and usage of Carthage, visit [its project page](https://github.com/Carthage/Carthage).

## Documentation
Cobra is a [VIPER](https://www.objc.io/issues/13-architecture/viper/)-based application routing framework for building modular iOS applications. Using Cobra, an application is broken up into VIPER modules, each module consisting of the following types: View, Interactor, Presenter, Router, Data Manager, Styler, Assembler, Storyboard and Feature. Each of these types own a [single responsibility](https://en.wikipedia.org/wiki/Single_responsibility_principle), i.e. the View is responsible for view logic, the Interactor is responsible for business logic, etc. Dividing application logic into distinct layers of responsibility this way enables developers to isolate dependencies, test interactions, and generally write clear and consistent code. 

## Creating a Module
Cobra works best when used with [Moccasin][3], which leverages Xcode templates to generate VIPER-based scaffolding. 

## Bootstrapping
Component frameworks and VIPER modules are bootstrapped like so:

    
        // Create a Cobra configuration for assembling the components and properties for the application
        let config = Config(components: [
            Component<DaemonAssembly>(),
            Component<ServiceAssembly>()
        ], properties: [
            JsonProperty(name: "properties")
        ])
        
        // Provide the configuration to the Cobra application
        try! App.sharedInstance.config(config)

        // Register Feature to Module proxies for the Cobra application routes
        App.sharedInstance.registerProxies([
            Proxy<AddCityFeatureType>(modules: Module<AddCityAssembly>()),
            Proxy<WeatherFeatureType>(modules: Module<WeatherAssembly>()),
            Proxy<WeatherDetailFeatureType>(modules: Module<WeatherDetailAssembly>())
        ])
        
        // Route to our first feature in our application window
        try! App.sharedInstance.feature(WeatherFeatureType.self).showInWindow(window!)
        return true
    }


[1]: https://github.com/Swinject/Swinject
[2]: https://github.com/locationlabs/Medusa
[3]: https://github.com/locationlabs/Moccasin
[4]: http://mutualmobile.github.io/blog/2013/12/04/viper-introduction/
[5]: https://github.com/locationlabs/Boa

