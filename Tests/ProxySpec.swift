import Quick
import Nimble
@testable import Cobra


class ProxySpec: QuickSpec {
    
    override func spec() {
        describe("proxy") {
            
            context("single module") {
                it("can lookup module without key") {
                    let proxy = Proxy<BarFeatureType>(modules: Module<BarAssembly>())
                    let module = try! proxy.lookupModule()
                    expect(module.assembly is BarAssembly) == true
                }
                
                it("can lookup module with key") {
                    let proxy = Proxy<BarFeatureType>(modules: Module<BarAssembly>(key: "bar"))
                    let module = try! proxy.lookupModule("bar")
                    expect(module.assembly is BarAssembly) == true
                }
                
                it("wont lookup module with invalid key") {
                    let proxy = Proxy<BarFeatureType>(modules: Module<BarAssembly>())
                    expect {
                        try proxy.lookupModule("bar3")
                    }.to(throwError(errorType: Error.self))
                }
            }
            
            context("multi modules") {

                it("can lookup module without key") {
                    let proxy = Proxy<BarFeatureType>(modules: Module<BarAssembly>(), Module<Bar2Assembly>())
                    let module = try! proxy.lookupModule()
                    expect(module.assembly is BarAssembly) == true
                }
                
                it("can lookup module with key") {
                    let proxy = Proxy<BarFeatureType>(modules: Module<BarAssembly>(key: "bar"), Module<Bar2Assembly>(key: "bar2"))
                    let module = try! proxy.lookupModule("bar")
                    expect(module.assembly is BarAssembly) == true
                }
                
                it("can lookup AB module with key") {
                    let proxy = Proxy<BarFeatureType>(modules: Module<BarAssembly>(key: "bar"), Module<Bar2Assembly>(key: "bar2"))
                    let module = try! proxy.lookupModule("bar2")
                    expect(module.assembly is Bar2Assembly) == true
                }
                
                it("wont lookup module with invalid key") {
                    let proxy = Proxy<BarFeatureType>(modules: Module<BarAssembly>(key: "bar"), Module<Bar2Assembly>(key: "bar2"))
                    expect {
                        try proxy.lookupModule("bar3")
                    }.to(throwError(errorType: Error.self))
                }
            }
        }
    }
}