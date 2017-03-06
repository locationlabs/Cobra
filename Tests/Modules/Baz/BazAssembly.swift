import Swinject
import Cobra


class BazAssembly: Constructible {
    required init() {}
}

// MARK: - AssemblyType
extension BazAssembly: Assembly {

    func assemble(container: Container) {
        
        // feature
        container.register(BazFeatureType.self) { _ in
            return BazFeature()
        }
    }

    func loaded(resolver: Resolver) {

    }
}
