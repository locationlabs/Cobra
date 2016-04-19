


class BazPresenter {
    
    var router: BazRouterType!
    var interactor: BazInteractorType!
    weak var view: BazViewType?
    
    init(view: BazViewType) {
        self.view = view
    }
}

protocol BazPresenterViewType: class {

}

// MARK: - BazPresenterViewType
extension BazPresenter: BazPresenterViewType {

}

protocol BazPresenterInteractorType: class {

}

// MARK: - BazPresenterInteractorType
extension BazPresenter: BazPresenterInteractorType {

}
