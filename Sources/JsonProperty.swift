import Foundation
import Swinject
import SwinjectPropertyLoader

/**
 The JsonProperty represents a Json property file that will be loaded into the application based on
 the flavor. If the flavor is nil, then it will always be loaded into the application
 */
final public class JsonProperty: PropertyType {
    
    public let propertyLoader: PropertyLoaderType
    public let flavor: Flavor?
    
    /**
     Creates a new Json property type
     
     - parameter bundle: the bundle where the resource exists
     - parameter name:   the name of the resource in the bundle
     - parameter type:   the type of the property resource
     */
    public init(bundle: Bundle = Bundle.main, name: String = "properties", flavor: Flavor? = nil) {
        self.propertyLoader = JsonPropertyLoader(bundle: bundle, name: name)
        self.flavor = flavor
    }
}

extension JsonProperty: CustomStringConvertible {
    public var description: String {
        return "{propertyLoader=\(propertyLoader), flavor=\(flavor)}"
    }
}
