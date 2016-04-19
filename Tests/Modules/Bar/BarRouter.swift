import UIKit
import LocoViper2


class BarRouter {
    
    weak var controller: UIViewController?
    
    init(controller: UIViewController) {
        self.controller = controller
    }
}

protocol BarRouterType: class {

}

// MARK: - BarRouterType
extension BarRouter: BarRouterType {
   
}
