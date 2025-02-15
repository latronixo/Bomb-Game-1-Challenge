//
//  Settings.swift
//  FirstChallengeGameBomb
//
//  Created by Валентин Картошкин on 15.02.2025.
//

import UIKit

struct Settings {
    struct Time {
        let text: String
        let countSeconds: Int
    }
    
    var backgroundMusic: String = "muzyika-dlya-sna-relaks"
    var soundTickingBomb: String = "tikane-taymera-bombyi"
    var soundBombBoom: String = "Boom"
    
    var vibration: Bool = true
    
    var tasks: Bool = true
}
