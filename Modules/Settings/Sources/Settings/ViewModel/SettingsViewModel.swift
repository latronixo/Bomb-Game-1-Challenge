import Foundation

enum SettingsSection {
    case titleSelection(title: String, viewModels: [TitleSettingsViewModel])
    case disclosureSection(viewModels: [DisclosureSettingsViewModel])
    case toggleSection(viewModels: [ToggleSettingsViewModel])
}

struct TitleSettingsViewModel {
    let title: String
    let isSelected: Bool
    let onSelect: () -> Void
}

struct DisclosureSettingsViewModel {
    let title: String
    let current: String
    let onTap: () -> Void
}

struct ToggleSettingsViewModel {
    let title: String
    let isOn: Bool
    let onToggle: () -> Void
}
