# Cobra
Cobra is a lightweight application routing framework written in Swift that provides modular abstractions
to your code base that is built on top of [Swinject][1], a lightweight dependency injection
framework.

## Features

- [X] Type safe application routing via features
- [X] Multiple flavor (e.g. environments) support for different components
- [X] Proxy powered routing for easy A/B testing of features
- [X] Foundation for modular code architecture

Cobra works best when used with [Medusa][2], an application daemon abstraction framework written in 
Swift and [Moccasin][3], Xcode templates that provides variation of [VIPER][5] architecture for 
iOS application.

## Requirements
- iOS8+
- Xcode 7.3+

## Installation
WIP

## Documentation
WIP

## TODO
This is the initial port of an internal framework developed at Location Labs for building
modular iOS applications. Be it that this library used to be used internally there are things
that haven't been implemented yet as there was no internal need

- [] Documentation
- [] More unit tests
- [] Travis CI integration
- [] Ensure Carthage support
- [] Swift Package Manager support
- [] TvOS, WatchOS, MacOS support
- [] Swiftlint support


[1]: https://github.com/Swinject/Swinject
[2]: https://github.com/locationlabs/Medusa
[3]: https://github.com/locationlabs/Moccasin
[4]: https://github.com/locationlabs/Boa
[5]: http://mutualmobile.github.io/blog/2013/12/04/viper-introduction/
