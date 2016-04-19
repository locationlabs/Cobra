

/**
 The Constructible protocol ensures that an implementation can be intialized through
 the default constructor. This allows us to lazy load modules and instantiate
 assemblies from property file names.
 */
public protocol Constructible {
    init()
}