import Swinject


/**
 Represents a module that is backed by an assembly. The assembly that this module is bound by will bootstap the
 DI container with service components that make the feature routable
*/
final public class Module<T where T: Constructible, T: AssemblyType>: ModuleType {
    
    /// will lazy load the assembly when the module is first visited through the proxy
    public lazy var assembly: AssemblyType = T()
    
    /// the key for this module that is based on the assembly type itself so we can lookup the module loaded for a proxy
    public let key: String
    
    /**
     Creates a module that wraps the Assembly that bootstraps the module
     
     - parameter key: the key for this module
     */
    public init(key: String = "\(T.self)") {
        self.key = key
    }
}
