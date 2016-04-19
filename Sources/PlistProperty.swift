import Foundation
import Swinject


/**
 The PlistProperty represents a Plist property file that will be loaded into the application based on
 the flavor. If the flavor is nil, then it will always be loaded into the application
 */
final public class PlistProperty: PropertyType {
    
    public let propertyLoader: PropertyLoaderType
    public let flavor: Flavor?
    
    /**
     Creates a new Plist property type
     
     - parameter bundle: the bundle where the resource exists
     - parameter name:   the name of the resource in the bundle
     - parameter type:   the type of the property resource
     */
    public init(bundle: NSBundle = NSBundle.mainBundle(), name: String = "properties", flavor: Flavor? = nil) {
        self.propertyLoader = PlistPropertyLoader(bundle: bundle, name: name)
        self.flavor = flavor
    }
}

extension PlistProperty: CustomStringConvertible {
    public var description: String {
        return "{propertyLoader=\(propertyLoader), flavor=\(flavor)}"
    }
}