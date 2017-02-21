import Swinject


/**
 The App class is the guts of the VIPER framework. Everything is to be registered and invoked from the App's sharedInstance.
 
 Responsibilities include:
    - Managing configuration
    - Managing the dependency injection container including lazy loading of modules on feature routing
    - Routing between features
    - Managing proxies and proxing features to the correct module
*/
final public class App {
    
    /// the proxy key to proxy mapping for feature routing
    fileprivate var proxies = [String:ProxyType]()

    /// track modules that were loaded so we don't reload them each time we route
    fileprivate var loadedModules = Set<String>()
    
    /// the assembly that contains all of the DI components, internal for testing purposes
    public var assembler: Assembler!
    
    /**
     Will configure the application with assemblies and properties. If the application is configured for push
     notifications this will boot strap the delegate as well
     
     - parameter config: the configuration to bootstrap the app with
     
     - throws: Swinject.PropertyLoaderError
     */
    public func config(_ config: Config, flavor: Flavor? = nil) throws {
        assembler = try config.buildAssembler(flavor)
    }
    
    /**
     Should be invoked in the app delegate to register proxies to modules for app routing. All modules will be
     lazy loaded by the framework for faster boottimes
     
     - parameter proxies: the proxies for the application
     */
    public func registerProxies(_ proxies: [ProxyType]) {
        for proxy in proxies {
            self.proxies[proxy.key] = proxy
        }
    }
    
    /**
     Will look up a feature from the configured proxies and lazy load its assembly into the container
     
     - parameter type: the feature to load
     - parameter key:  the AB test key for which module to load for this feature
     
     - throws: MissingProxy, MissingFeature, ProxyMissingModules
     
     - returns: the feature type instance for routing
     */
    public func feature<T>(_ type: T.Type, moduleKey: String? = nil) throws -> T {
        // convert feature to proxy key and lookup proxy
        let key = toProxyKey(T.self)
        logDebug("Will lookup proxy for key=\(key)")
        
        guard let proxy = proxies[key] else {
            throw Error.missingProxy
        }

        // lookup the module for the given proxy which is configured by tweaks
        let module = try proxy.lookupModule(moduleKey)
        logDebug("Found module for key=\(module.key), via proxy key=\(key)")

        if !loadedModules.contains(module.key) {
            // lazy load the assembly
            assembler.apply(assembly: module.assembly)
            logDebug("Lazy loaded assembly=\(module.assembly) for key=\(module.key)")
            
            // insert module to loaded so we only lazy load once
            loadedModules.insert(module.key)
            
            // clear previously loaded keys so we can handle runtime stuff
            let unloadKeys = proxy.unloadModuleKeys(notIncludingKey: module.key)
            for key in unloadKeys {
                loadedModules.remove(key)
            }
        } else {
            logDebug("Assembly already loaded. Skipping ondemand load for assembly=\(module.assembly)")
        }
        
        // lookup the feature from the resolver
        guard let feature = assembler.resolver.resolve(T.self) else {
            throw Error.missingFeature
        }
        return feature
    }
}

// MARK: - Singleton
extension App {
    public static let sharedInstance = App()
}
