import Foundation

protocol ISettingsPresenter {
    func viewDidLoad()
}

final class SettingsPresenter {
    weak var view: ISettingsViewController?
    private let settingsService: ISettingsService
    
    init(settingsService: ISettingsService) {
        self.settingsService = settingsService
    }
}

extension SettingsPresenter: ISettingsPresenter {
    func viewDidLoad() {
        prepareViewModels()
    }
}

private extension SettingsPresenter {
    func prepareViewModels() {
        let viewModels: [SettingsSection] = [
            createTitleSection(),
            createDisclosureSection(),
            createToggleSection()
        ]
        view?.updateView(viewModels)
    }
    
    func createTitleSection() -> SettingsSection {
        let titles: [TitleSettingsViewModel] = [
            .init(title: "Короткое", type: .short, isSelected: false, onSelect: {  }),
            .init(title: "Среднее", type: .middle, isSelected: false, onSelect: {  }),
            .init(title: "Длинное", type: .long, isSelected: false, onSelect: {  }),
            .init(title: "Случайное", type: .random, isSelected: false, onSelect: {  })
        ]
        return .titleSelection(title: "ВРЕМЯ ИГРЫ", viewModels: titles)
    }
    
    func createDisclosureSection() -> SettingsSection {
        let models: [DisclosureSettingsViewModel] = [
            .init(title: "Фоновая музыка", current: "Мелодия 1", onTap: { }),
            .init(title: "Тиканье бомбы", current: "Часы 2", onTap: { }),
            .init(title: "Взрыв бомбы", current: "Взрыв 1", onTap: { })
        ]
        return .disclosureSection(viewModels: models)
    }
    
    func createToggleSection() -> SettingsSection {
        let models: [ToggleSettingsViewModel] = [
            .init(title: "Вибрация", isOn: true, onToggle: { }),
            .init(title: "Игра с заданиями", isOn: false, onToggle: { })
        ]
        return .toggleSection(viewModels: models)
    }
}
