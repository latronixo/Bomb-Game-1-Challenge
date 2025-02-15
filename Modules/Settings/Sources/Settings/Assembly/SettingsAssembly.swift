import UIKit

public final class SettingsAssembly {
    @MainActor public static func assemble() -> UIViewController {
        let settingsService = SettingsService()
        let tableManager = SettingsTableManager()
        let presenter = SettingsPresenter(settingsService: settingsService)
        let view = SettingsViewController(presenter: presenter, tableManager: tableManager)
        
        presenter.view = view
        return view
    }
}
