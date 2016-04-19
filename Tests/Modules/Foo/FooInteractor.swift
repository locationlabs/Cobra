

class FooInteractor {
    
    weak var presenter: FooPresenterInteractorType?
    var dataManager: FooDataManagerType!
    
    init(presenter: FooPresenterInteractorType) {
        self.presenter = presenter
    }
}

protocol FooInteractorType: class {

}

// MARK: - FooInteractorType
extension FooInteractor: FooInteractorType {

}
