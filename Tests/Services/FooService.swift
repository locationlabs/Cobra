


class FooService {
    
    var appProp: String
    var envProp: String
    
    init(appProp: String, envProp: String) {
        self.appProp = appProp
        self.envProp = envProp
    }
}

protocol FooServiceType: class {
    var appProp: String { get }
    var envProp: String { get }
}

// MARK: - FooServiceType
extension FooService: FooServiceType {
    
}
