import Foundation

public actor SettingsValues {
    @UserDefault(key: "isOnHaptic", defaultValue: true)
    public static var isOnHaptic: Bool
    @UserDefault(key: "gameTime", defaultValue: .random)
    public static var gameTime: GameTime
}
