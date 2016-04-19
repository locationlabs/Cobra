import Swinject


/**
 The ModuleType protocol represents a VIPER module and is responsible for managing its assembly
 */
public protocol ModuleType {
    
    /// the assembly that is backing this module
    var assembly: AssemblyType { get }
    
    /// the key for this module that is based on the assembly type itself so we can lookup the module loaded for a proxy
    var key: String { get }
}