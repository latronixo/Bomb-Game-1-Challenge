import UIKit

protocol ISettingsViewController: AnyObject {
    func updateView(_ viewModels: [SettingsSection])
}

final class SettingsViewController: UIViewController {
    private let presenter: ISettingsPresenter
    private let tableManager: ISettingsTableManager
    
    private lazy var backgroundLayer: CALayer = {
        let image = ModuleAsset.backgroundImage
        let layer = CALayer()
        layer.frame = view.bounds
        layer.contents = image.cgImage
        layer.contentsGravity = .resizeAspectFill
        return layer
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        return table
    }()
    
    init(presenter: ISettingsPresenter, tableManager: ISettingsTableManager) {
        self.presenter = presenter
        self.tableManager = tableManager
        super.init(nibName: nil, bundle: nil)
        tableManager.setup(table: tableView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard backgroundLayer.superlayer == nil else { return }
        view.layer.insertSublayer(backgroundLayer, at: .zero)
    }
}

extension SettingsViewController: @preconcurrency ISettingsViewController {
    func updateView(_ viewModels: [SettingsSection]) {
        tableManager.reloadTable(viewModels)
    }
}

private extension SettingsViewController {
    func setupView() {
        view.backgroundColor = ModuleAsset.backgroundColor
    }
}
