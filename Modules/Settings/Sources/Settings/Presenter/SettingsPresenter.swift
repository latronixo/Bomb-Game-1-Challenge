import Foundation

protocol ISettingsPresenter {
    
}

final class SettingsPresenter {
    weak var view: ISettingsViewController?
    private let settingsService: ISettingsService
    
    init(settingsService: ISettingsService) {
        self.settingsService = settingsService
    }
}

extension SettingsPresenter: ISettingsPresenter {
    
}
