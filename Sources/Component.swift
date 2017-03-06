import Swinject


/**
 The Component class wraps an AssemblyType that to implement the ComponentType protocol. This class will just
 forward the Assembly Construction reguardless of the flavor
 */
final public class Component<A> where A: Constructible, A: Assembly {
    public init() {}
}

// MARK: - ComponentType
extension Component: ComponentType {
    public func assemblyForFlavor(_ flavor: Flavor?) -> Assembly {
        return A()
    }
}
