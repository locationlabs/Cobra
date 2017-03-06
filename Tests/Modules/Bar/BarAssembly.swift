import Swinject
import Cobra


class BarAssembly: Constructible {
    required init() {}
}

// MARK: - AssemblyType
extension BarAssembly: Assembly {

    func assemble(container: Container) {
        
        // feature
        container.register(BarFeatureType.self) { _ in
            return BarFeature()
        }
    }

    func loaded(resolver: Resolver) {

    }
}
