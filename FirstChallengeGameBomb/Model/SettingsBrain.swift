//
//  SettingsBrain.swift
//  FirstChallengeGameBomb
//
//  Created by Валентин Картошкин on 15.02.2025.
//

import UIKit
import Settings

struct SettingsBrain {
    
    @UserDefault(key: "selectedTimeKey", defaultValue: 0)
     var selectedTime: Int {
        didSet {
            print("Выбранное время обновлено: \(selectedTime)")
        }
    }
    
    var settings = Settings()
    
    var times = [
        Settings.Time(text: "Короткое", countSeconds: 10),
        Settings.Time(text: "Среднее", countSeconds: 20),
        Settings.Time(text: "Длинное", countSeconds: 45),
        Settings.Time(text: "Случайное", countSeconds: Int.random(in: 10...45))
    ]
    
    init() {
        if UserDefaults.standard.object(forKey: "selectedTimeKey") == nil {
            selectedTime = 0
            print("Установлено значение по умолчанию: Короткое время")
        }
    }
    
    //устанавливаем настройки (для экрана Settings)
    mutating func setSettings(durationGame: Int, backgroundMusic: String, soundTickingMusic: String, soundBompBoom: String, vibration: Bool, tasks: Bool) {
        selectedTime = durationGame
        settings.backgroundMusic = backgroundMusic
        settings.soundTickingBomb = soundTickingMusic
        settings.soundBombBoom = soundBompBoom
        settings.vibration = vibration
        settings.tasks = tasks
    }
    
    //получить длительность игры
    func getDurationGame() -> Int {
        return times[selectedTime].countSeconds
    }

    //получить имя файла фоновой музыки
    func getBackgroundMusic() -> String {
        return settings.backgroundMusic
    }
    
    //получить имя файла тиканья бомбы
    func getSoundTickingBomb() -> String {
        return settings.soundTickingBomb
    }

    //получить имя файла взрыва бомбы
    func getSoundBombBoom() -> String {
        return settings.soundBombBoom
    }

    //получить вибрацию
    func getVibration() -> Bool {
        return settings.vibration
    }
    
    //получить задания
    func getTasks() -> Bool {
        return settings.tasks
    }

}
