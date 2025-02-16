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
    
    @UserDefault(key: "backgroundMusic", defaultValue: "Melody1")
    var backgroundMusicValue: String
    
    @UserDefault(key: "tickingBombMusic", defaultValue: "Ticking2")
    var tickingBombMusicValue: String
    
    @UserDefault(key: "bombBoomMusic", defaultValue: "Boom")
    var bombBoomMusicValue: String
    
    @UserDefault(key: "onVibration", defaultValue: true)
    var onVibration: Bool
    
    @UserDefault(key: "onTasks", defaultValue: true)
    var onTasks: Bool
    
    var settings = Settings()
    
    var times = [
        Settings.Time(text: "Короткое", countSeconds: 10),
        Settings.Time(text: "Среднее", countSeconds: 20),
        Settings.Time(text: "Длинное", countSeconds: 45),
        Settings.Time(text: "Случайное", countSeconds: Int.random(in: 10...45))
    ]
    
    var backgroundMusic = [
        Settings.Music(title: "Мелодия 1", fileName: "Melody1"),
        Settings.Music(title: "Мелодия 2", fileName: "Melody2"),
        Settings.Music(title: "Мелодия 3", fileName: "Melody3"),
        Settings.Music(title: "Мелодия 4", fileName: "Melody4"),
        Settings.Music(title: "Мелодия 5", fileName: "Melody5"),
        Settings.Music(title: "Мелодия 6", fileName: "Melody6"),
        Settings.Music(title: "Мелодия 7", fileName: "muzyika-dlya-sna-relaks")
    ]
    
    var tickingBombMusic = [
        Settings.Music(title: "Часы 1", fileName: "Ticking2"),
        Settings.Music(title: "Часы 2", fileName: "Ticking3"),
        Settings.Music(title: "Часы 3", fileName: "tikane-taymera-bombyi"),
    ]
    
    var bombBoomMusic = [
        Settings.Music(title: "Взрыв 1", fileName: "Boom"),
        Settings.Music(title: "Взрыв 2", fileName: "Boom2"),
        Settings.Music(title: "Взрыв 3", fileName: "Boom3")
    ]
    
    init() {
        if UserDefaults.standard.object(forKey: "selectedTimeKey") == nil {
            selectedTime = 0
            print("Установлено значение по умолчанию: Короткое время")
        }
        
        if UserDefaults.standard.object(forKey: "backgroundMusic") == nil {
            backgroundMusicValue = "Melody1"
        }
        
        if UserDefaults.standard.object(forKey: "tickingBombMusic") == nil {
            tickingBombMusicValue = "Ticking2"
        }
        
        if UserDefaults.standard.object(forKey: "bombBoomMusic") == nil {
            bombBoomMusicValue = "Boom"
        }
        
        if UserDefaults.standard.object(forKey: "onVibration") == nil {
            onVibration = true
        }
        
        if UserDefaults.standard.object(forKey: "onTasks") == nil {
            onTasks = true
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
        return backgroundMusicValue
    }
    
    //получить имя файла тиканья бомбы
    func getSoundTickingBomb() -> String {
        return tickingBombMusicValue
    }

    //получить имя файла взрыва бомбы
    func getSoundBombBoom() -> String {
        return bombBoomMusicValue
    }

    //получить вибрацию
    func getVibration() -> Bool {
        return onVibration
    }
    
    //получить задания
    func getTasks() -> Bool {
        return onTasks
    }

}
