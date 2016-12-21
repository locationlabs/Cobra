import Quick
import Nimble
@testable import Cobra


// create some flavors for testing
extension Flavor {
    static let Dev = Flavor("Dev")
    static let Prod = Flavor("Prod")
}

class AppSpec: QuickSpec {
    
    override func spec() {
        describe("app") {
            
            context("feature lookup") {
                
                var app: App!
                let config = Config()
                
                beforeEach {
                    app = App()
                    try! app.config(config)
                    app.registerProxies([
                        Proxy<FooFeatureType>(modules: Module<FooAssembly>()),
                        Proxy<BarFeatureType>(modules: Module<BarAssembly>(), Module<Bar2Assembly>(key: "bar2"))
                    ])
                }

                it("can lookup feature") {
                    let foo = try! app.feature(FooFeatureType.self)
                    expect(foo is FooFeature) == true
                    
                    let bar = try! app.feature(BarFeatureType.self)
                    expect(bar is BarFeature) == true
                }
                
                it("can lookup feature for ab test") {
                    
                    let bar = try! app.feature(BarFeatureType.self)
                    expect(bar is BarFeature) == true
                    
                    let bar2 = try! app.feature(BarFeatureType.self, moduleKey: "bar2")
                    expect(bar2 is Bar2Feature) == true
                }
            }
            
            context("with properties") {
                
                var app: App!
                let config = Config(components: [
                        Component<ServiceAssembly>()
                    ],
                    properties: [
                        JsonProperty(bundle: Bundle(for: AppSpec.self))
                    ])
                
                beforeEach {
                    app = App()
                    try! app.config(config)
                }
                
                it("can load assembly from properties") {
                    let service = app.assembler.resolver.resolve(FooServiceType.self)
                    expect(service).toNot(beNil())
                    expect(service!.appProp) == "hello world"
                    expect(service!.envProp) == "properties.json"
                }
                
                context("multi") {
                    
                    var app: App!
                    let config = Config(components: [
                            Component<ServiceAssembly>()
                        ],
                        properties: [
                            JsonProperty(bundle: Bundle(for: AppSpec.self)),
                            JsonProperty(bundle: Bundle(for: AppSpec.self), name: "properties2")
                        ])
                    
                    beforeEach {
                        app = App()
                        try! app.config(config)
                    }
                    
                    it("can load assembly from properties") {
                        let service = app.assembler.resolver.resolve(FooServiceType.self)
                        expect(service).toNot(beNil())
                        expect(service!.appProp) == "properties2.json"
                        expect(service!.envProp) == "properties.json"
                    }
                }
                
                context("flavor") {
                    
                    var app: App!
                    let config = Config(components: [
                            Component<ServiceAssembly>()
                        ],
                        properties: [
                            JsonProperty(bundle: Bundle(for: AppSpec.self)),
                            JsonProperty(bundle: Bundle(for: AppSpec.self), name: "dev", flavor: .Dev),
                            JsonProperty(bundle: Bundle(for: AppSpec.self), name: "prod", flavor: .Prod)
                        ]
                    )
                    
                    beforeEach {
                        app = App()
                    }
                    
                    it("can load assembly from flavor dev properties") {
                        try! app.config(config)
                        
                        let service = app.assembler.resolver.resolve(FooServiceType.self)
                        expect(service).toNot(beNil())
                        expect(service!.appProp) == "hello world"
                        expect(service!.envProp) == "properties.json"
                    }
                    
                    it("can load assembly from flavor dev properties") {
                        try! app.config(config, flavor: .Dev)
                        
                        let service = app.assembler.resolver.resolve(FooServiceType.self)
                        expect(service).toNot(beNil())
                        expect(service!.appProp) == "hello world"
                        expect(service!.envProp) == "dev.json"
                    }
                    
                    it("can load assembly from flavor prod properties") {
                        try! app.config(config, flavor: .Prod)
                        
                        let service = app.assembler.resolver.resolve(FooServiceType.self)
                        expect(service).toNot(beNil())
                        expect(service!.appProp) == "hello world"
                        expect(service!.envProp) == "prod.json"
                    }
                }
            }
            
            context("invalid") {
                
                var app: App!
                let config = Config()
                
                beforeEach {
                    app = App()
                    try! app.config(config)
                    app.registerProxies([
                        Proxy<FooFeatureType>(modules: Module<BarAssembly>())
                    ])
                }
                
                it("will throw error if feature proxy does not exist") {
                    expect {
                        try app.feature(BazFeatureType.self)
                    }.to(throwError(errorType: Error.self))
                }
                
                it("will throw error if proxy exists, but feature does not") {
                    expect {
                        try app.feature(FooFeatureType.self)
                    }.to(throwError(errorType: Error.self))
                }
            }
        }
    }
}
