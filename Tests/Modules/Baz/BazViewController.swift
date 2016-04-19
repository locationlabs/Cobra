import UIKit


class BazViewController: UIViewController {
    
    var presenter: BazPresenterViewType!
    var styler: BazStyleType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyStyles()
    }

    private func applyStyles() {
        
    }
}

protocol BazViewType: class {
    
}

// MARK: - BazViewType
extension BazViewController: BazViewType {
   
}
