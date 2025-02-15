import UIKit
import SnapKit

protocol ISettingsViewController: AnyObject {
    func updateView(_ viewModels: [SettingsSection])
}

final class SettingsViewController: BaseViewController {
    private let presenter: ISettingsPresenter
    private let tableManager: ISettingsTableManager
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.backgroundColor = .clear
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
        addSubviews()
        makeConstraints()
        presenter.viewDidLoad()
    }
}

extension SettingsViewController: @preconcurrency ISettingsViewController {
    func updateView(_ viewModels: [SettingsSection]) {
        tableManager.reloadTable(viewModels)
    }
}

private extension SettingsViewController {
    func addSubviews() {
        [tableView].forEach({ view.addSubview($0) })
    }
    
    func makeConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }
}
