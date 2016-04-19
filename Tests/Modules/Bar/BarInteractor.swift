

class BarInteractor {
    
    weak var presenter: BarPresenterInteractorType?
    var dataManager: BarDataManagerType!
    
    init(presenter: BarPresenterInteractorType) {
        self.presenter = presenter
    }
}

protocol BarInteractorType: class {

}

// MARK: - BarInteractorType
extension BarInteractor: BarInteractorType {

}
