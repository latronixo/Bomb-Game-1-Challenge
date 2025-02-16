import Foundation

public struct CurrentSettings {
    public static var gameTime: GameTime {
        SettingsValues.gameTime
    }
}

public enum GameTime {
    case short, middle, long, random
}
