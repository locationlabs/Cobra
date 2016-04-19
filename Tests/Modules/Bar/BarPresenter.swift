


class BarPresenter {
    
    var router: BarRouterType!
    var interactor: BarInteractorType!
    weak var view: BarViewType?
    
    init(view: BarViewType) {
        self.view = view
    }
}

protocol BarPresenterViewType: class {

}

// MARK: - BarPresenterViewType
extension BarPresenter: BarPresenterViewType {

}

protocol BarPresenterInteractorType: class {

}

// MARK: - BarPresenterInteractorType
extension BarPresenter: BarPresenterInteractorType {

}
