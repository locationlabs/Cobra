import UIKit
import LocoViper2


class BazRouter {
    
    weak var controller: UIViewController?
    
    init(controller: UIViewController) {
        self.controller = controller
    }
}

protocol BazRouterType: class {

}

// MARK: - BazRouterType
extension BazRouter: BazRouterType {
   
}
