import UIKit


class BarViewController: UIViewController {
    
    var presenter: BarPresenterViewType!
    var styler: BarStyleType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyStyles()
    }

    private func applyStyles() {
        
    }
}

protocol BarViewType: class {
    
}

// MARK: - BarViewType
extension BarViewController: BarViewType {
   
}
