import Swinject


/**
 The ComponentType protocol represents an assembly of components, services, daemons, etc. that will be loaded based 
 on the current flavor of the App
 */
public protocol ComponentType {
    
    /**
     Will retrieve an AssemblyType for the given flavor
     
     - parameter flavor: the flavor to retreive
     
     - returns: the assembly type that should be loaded for the component based on the provided flavor
     */
    func assemblyForFlavor(flavor: Flavor?) -> AssemblyType
}