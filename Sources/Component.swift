import Swinject


/**
 The Component class wraps an AssemblyType that to implement the ComponentType protocol. This class will just
 forward the Assembly Construction reguardless of the flavor
 */
final public class Component<Assembly where Assembly: Constructible, Assembly: AssemblyType> {
    public init() {}
}

// MARK: - ComponentType
extension Component: ComponentType {
    public func assemblyForFlavor(flavor: Flavor?) -> AssemblyType {
        return Assembly()
    }
}
