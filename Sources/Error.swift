

/**
 Represents errors that can be thrown by the VIPER framework
 
 - MissingFeature:      Attempting to load a feature that does not exist in the container
 - MissingProxy:        Adding to load a feature that is not registered via a proxy
 - MissingModule:       Attempting to proxy to a module whose key is not associated with the Proxy
 */
public enum Error: Swift.Error {

    case missingFeature
    case missingProxy
    case missingModule
}
