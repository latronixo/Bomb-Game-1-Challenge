import UIKit

protocol ISettingsTableManager {
    func setup(table: UITableView)
}

final class SettingsTableManager: NSObject {
    private weak var tableView: UITableView?
    private var sections = [SettingsSection]()
}

extension SettingsTableManager: @preconcurrency ISettingsTableManager {
    @MainActor func setup(table: UITableView) {
        tableView = table
        tableView?.delegate = self
        tableView?.dataSource = self
        
        tableView?.register(
            SelectionTitleTableViewCell.self,
            forCellReuseIdentifier: SelectionTitleTableViewCell.reuseIdentifier
        )
        
        tableView?.register(
            ToggleSettingsTableViewCell.self,
            forCellReuseIdentifier: ToggleSettingsTableViewCell.reuseIdentifier
        )
        
        tableView?.register(
            DisclosureSettingsTableViewCell.self,
            forCellReuseIdentifier: DisclosureSettingsTableViewCell.reuseIdentifier
        )
    }
}

extension SettingsTableManager: UITableViewDelegate {
    
}

extension SettingsTableManager: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = sections[safe: section] else { return .zero }
        switch section {
        case .titleSelection(_, let viewModels):
            return viewModels.isEmpty ? .zero : 1
        case .disclosureSection(let viewModels):
            return viewModels.count
        case .toggleSection(let viewModels):
            return viewModels.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = sections[safe: indexPath.section] else { return .init() }
        switch section {
        case .titleSelection(_, let viewModels):
            guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: SelectionTitleTableViewCell.reuseIdentifier
                  ) as? SelectionTitleTableViewCell else { return .init() }
            cell.fill(viewModels)
            return cell
        case .disclosureSection(let viewModels):
            guard let viewModel = viewModels[safe: indexPath.row],
                  let cell = tableView.dequeueReusableCell(
                    withIdentifier: DisclosureSettingsTableViewCell.reuseIdentifier
                  ) as? DisclosureSettingsTableViewCell else { return .init() }
            cell.fill(viewModel)
            return cell
        case .toggleSection(let viewModels):
            guard let viewModel = viewModels[safe: indexPath.row],
                  let cell = tableView.dequeueReusableCell(
                    withIdentifier: ToggleSettingsTableViewCell.reuseIdentifier
                  ) as? ToggleSettingsTableViewCell else { return .init() }
            cell.fill(viewModel)
            return cell
        }
    }
}
