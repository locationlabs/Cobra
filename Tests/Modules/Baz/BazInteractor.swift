

class BazInteractor {
    
    weak var presenter: BazPresenterInteractorType?
    var dataManager: BazDataManagerType!
    
    init(presenter: BazPresenterInteractorType) {
        self.presenter = presenter
    }
}

protocol BazInteractorType: class {

}

// MARK: - BazInteractorType
extension BazInteractor: BazInteractorType {

}
