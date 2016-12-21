import Swinject
import Cobra


class BarAssembly: Constructible {
    required init() {}
}

// MARK: - AssemblyType
extension BarAssembly: AssemblyType {

    func assemble(container: Container) {
        
        // feature
        container.register(BarFeatureType.self) { _ in
            return BarFeature()
        }
    }

    func loaded(resolver: ResolverType) {

    }
}
