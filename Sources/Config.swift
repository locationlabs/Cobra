import Swinject


/**
 The Config object is used to bootstrap a VIPER App with assemblies and properties for the DI container
*/
final public class Config {
    
    /// list of components to load into the container
    private let components: [ComponentType]
    
    /// list of properties from frameworks (e.g. properties.json)
    private let properties: [PropertyType]

    /**
     Will create a configuration object that can be used to bootstrap a VIPER application
     
     - parameter components:   the list of property keys that point to AssemblyType classes
     - parameter properties:   a list of property files that will be loaded into the assembler for property resolution
     */
    public init(components: [ComponentType] = [], properties: [PropertyType] = []) {
        self.components = components
        self.properties = properties
    }
    
    /**
     Will build the assembler from the configuration by loading properties and assemblies from the properties
     into the assembler.
     
     - parameter: flavor the flavor to bootstrap the container with
     
     - throws: Swinject.PropertyLoaderError
     
     - returns: the built assembler
     */
    func buildAssembler(flavor: Flavor? = nil) throws -> Assembler {
        
        // load the properties first
        let assembler = Assembler()

        for property in properties.filter({ $0.flavor == nil || $0.flavor == flavor }) {
            try assembler.applyPropertyLoader(property.propertyLoader)
            logDebug("Loaded properties=\(property), for flavor=\(flavor)")
        }
        
        // load assemblies from components
        let assemblies = components.map { $0.assemblyForFlavor(flavor) }
        assembler.applyAssemblies(assemblies)
        logDebug("Applied assemblies=\(assemblies), for flavor=\(flavor)")
        return assembler
    }
}
