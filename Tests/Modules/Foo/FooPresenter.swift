


class FooPresenter {
    
    var router: FooRouterType!
    var interactor: FooInteractorType!
    weak var view: FooViewType?
    
    init(view: FooViewType) {
        self.view = view
    }
}

protocol FooPresenterViewType: class {

}

// MARK: - FooPresenterViewType
extension FooPresenter: FooPresenterViewType {

}

protocol FooPresenterInteractorType: class {

}

// MARK: - FooPresenterInteractorType
extension FooPresenter: FooPresenterInteractorType {

}
