import Foundation
import Swinject
import SwinjectPropertyLoader


/**
 The PropertyType protocol provides a thin wrapper around a Swinject PropertyLoaderType that allows certain
 properties to be loaded based on a Cobra Flavor
 */
public protocol PropertyType {
    
    /// the Swinject property loader that will be used to load properties from disk
    var propertyLoader: PropertyLoaderType { get }
    
    /// the flavor in which the properties should be loaded for. If nil, then the properties will always be loaded
    var flavor: Flavor? { get }
}
