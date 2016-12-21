

/**
 The ProxyType protocol provides a uniform proxy interface for the generic Proxy<T> class so we can group the proxies
 into a collection like an array or dictionary
 */
public protocol ProxyType: class {
    
    /// the key that can be used to identity the proxy (NOTE: not using Equatable/Hashable because it breaks the ablity
    /// to group proxies into collections due to Self conformance
    var key: String { get }
    
    /**
     Will lookup the module that is currently configured behind the proxy. The proxy configuration is driven by tweaks
     so it can be changed at runtime
     
     - throws: ProxyMissingModules
     
     - returns: the module that is currently configured behind the proxy
     */
    func lookupModule(_ key: String?) throws -> ModuleType
    
    /**
     Will retrieve the keys that should be unloaded for the proxy. This is used when we need to switch
     the loaded module behind the proxy at runtime so that only 1 module exists in the loaded cache at a time.
     
     - parameter key: the key that is about to be loaded so should be ignored from the unloaded set
     
     - returns: the keys to be removed from the loaded modules cache
     */
    func unloadModuleKeys(notIncludingKey key: String) -> [String]
}
