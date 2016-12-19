import Swinject
import Cobra


class FooAssembly: Constructible {
    required init() {}
}

// MARK: - AssemblyType
extension FooAssembly: AssemblyType {

    func assemble(_ container: Container) {
        
        // feature
        container.register(FooFeatureType.self) { _ in
            return FooFeature()
        }
    }

    func loaded(_ resolver: ResolverType) {

    }
}
