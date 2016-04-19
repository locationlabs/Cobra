import UIKit


class FooViewController: UIViewController {
    
    var presenter: FooPresenterViewType!
    var styler: FooStyleType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyStyles()
    }

    private func applyStyles() {
        
    }
}

protocol FooViewType: class {
    
}

// MARK: - FooViewType
extension FooViewController: FooViewType {
   
}
