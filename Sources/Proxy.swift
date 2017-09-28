



/**
 The Proxy class represents a proxy to a given feature. A feature can be proxied to 1 or more modules but only 1 module
 will be loaded at a time. The modules can be swapped at runtime using the Tweaks menu.
*/
final public class Proxy<T>: ProxyType {
    
    /// the list of modules that a proxy can proxy to
    fileprivate let modules: [ModuleType]
    
    /// unique key for the proxy feature
    public let key: String
    
    /**
     Create a proxy for a feature that can be proxied to different modules
     
     - parameter modules: the modules that is configured behind our proxy
     
     - throws: ProxyMissingModules
     */
    public init(key: String = toProxyKey(T.self), modules: ModuleType...) {
        self.modules = modules
        self.key = key
    }
    
    /**
     Will look up the module that is currently configured for the proxy
     
     - throws: ProxyMissingModules
     
     - returns: the module that is configured behind tweaks for the feature proxy
     */
    public func lookupModule(_ key: String? = nil) throws -> ModuleType {
        guard let lookupKey = key else {
            return modules.first!
        }
        guard let module = modules.filter({ $0.key == lookupKey }).first else {
            throw Error.missingModule
        }
        return module
    }
    
    /**
     Will retrieve the keys that should be unloaded for the proxy. This is used when we need to switch
     the loaded module behind the proxy at runtime so that only 1 module exists in the loaded cache at a time.
    
     - parameter key: the key that is about to be loaded so should be ignored from the unloaded set

     - returns: the keys to be removed from the loaded modules cache
    */
    public func unloadModuleKeys(notIncludingKey key: String) -> [String] {
        return modules.filter { $0.key != key }.map { $0.key }
    }
}

/**
 Helper function to convert a feature type into a proxy key
 
 - parameter type: the feature type to convert to a proxy key
 
 - returns: the proxy key
 */
public func toProxyKey<T>(_ type: T.Type) -> String {
    return "\(T.self)"
}
