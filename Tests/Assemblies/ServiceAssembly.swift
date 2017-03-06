import Swinject
import SwinjectPropertyLoader
import Cobra


/**
The ServiceAssembly assembles services for tests
*/
class ServiceAssembly: Constructible {
    required init() {}
}

// MARK: - AssemblyType
extension ServiceAssembly: Assembly {

    func assemble(container: Container) {
        container.register(FooServiceType.self) { resolver in
            return FooService(appProp: resolver.property("app.prop")!,
                              envProp: resolver.property("env.prop")!)
        }
    }

    func loaded(_ resolver: Resolver) {

    }
}
