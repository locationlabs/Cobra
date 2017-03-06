import Swinject
import Cobra


class Bar2Assembly: Constructible {
    required init() {}
}

// MARK: - AssemblyType
extension Bar2Assembly: Assembly {
    
    func assemble(container: Container) {
        
        // feature
        container.register(BarFeatureType.self) { _ in
            return Bar2Feature()
        }
    }
    
    func loaded(resolver: Resolver) {
        
    }
}
