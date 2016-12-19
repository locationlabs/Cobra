import Swinject
import Cobra


class BazAssembly: Constructible {
    required init() {}
}

// MARK: - AssemblyType
extension BazAssembly: AssemblyType {

    func assemble(_ container: Container) {
        
        // feature
        container.register(BazFeatureType.self) { _ in
            return BazFeature()
        }
    }

    func loaded(_ resolver: ResolverType) {

    }
}
