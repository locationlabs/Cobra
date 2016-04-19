import Quick
import Nimble
@testable import Cobra


class FlavorComponentSpec: QuickSpec {
    
    override func spec() {
        describe("flavor component") {
            
            let component = FlavorComponent<FooAssembly, BarAssembly>(flavor: .Dev)
            
            it("can lookup normal component") {
                expect(component.assemblyForFlavor(nil) is FooAssembly) == true
            }
            
            it("can lookup flavor component") {
                expect(component.assemblyForFlavor(.Dev) is BarAssembly) == true
            }
        }
    }
}