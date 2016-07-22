

/**
 The Flavor class provides which type of flavor a paricular component exists for. This is used to represent different
 Component to load into the application based on a configured flavor. For example, you can have a Mock, Dev, or Production
 flavor of your application which will load a different configuration of assemblies into the container.
 
 You can add as many flavors to your application as you want by extending this class and adding a static property
 to it
 
 ```
 // MARK: - Default extensions
 public extension Flavor {
    public static let Mock = Flavor("Mock")
 }
 ```
 */
public struct Flavor: Equatable {
    public var value: String
    public init(_ value: String) {
        self.value = value
    }
}

public func ==(lhs: Flavor, rhs: Flavor) -> Bool {
    return lhs.value == rhs.value
}