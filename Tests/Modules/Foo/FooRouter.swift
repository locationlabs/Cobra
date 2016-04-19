import UIKit
import LocoViper2


class FooRouter {
    
    weak var controller: UIViewController?
    
    init(controller: UIViewController) {
        self.controller = controller
    }
}

protocol FooRouterType: class {

}

// MARK: - FooRouterType
extension FooRouter: FooRouterType {
   
}
