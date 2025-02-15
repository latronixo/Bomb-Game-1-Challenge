//
//  Settings.swift
//  FirstChallengeGameBomb
//
//  Created by Валентин Картошкин on 15.02.2025.
//

import UIKit

enum MusicType {
    case backgroundMusic
    case soundTickingBomb
    case soundBombBoom
}

struct Settings {
    struct Time {
        let text: String
        let countSeconds: Int
    }
    
    struct Music {
        let title: String
        let fileName: String
    }
    
    var backgroundMusic: String = "muzyika-dlya-sna-relaks"
    var soundTickingBomb: String = "tikane-taymera-bombyi"
    var soundBombBoom: String = "Boom"
    
    var vibration: Bool = true
    
    var tasks: Bool = true
}
