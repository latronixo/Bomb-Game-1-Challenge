import UIKit

protocol ISettingsViewController: AnyObject {
    
}

final class SettingsViewController: UIViewController {
    private let presenter: ISettingsPresenter
    
    init(presenter: ISettingsPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SettingsViewController: ISettingsViewController {
    
}
