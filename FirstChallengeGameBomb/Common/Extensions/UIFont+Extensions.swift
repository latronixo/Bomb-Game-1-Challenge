//
//  UIFont+Extensions.swift
//  FirstChallengeGameBomb
//
//  Created by Александр Пеньков on 11.02.2025.
//

import UIKit

extension UIFont {
    public enum fontType: String {
        case sfProRoundedBlack = "SFProRounded-Black"
        case sfProRoundedBold = "SFProRounded-Bold"
        case sfProRoundedHeavy = "SFProRounded-Heavy"
        case sfProRoundedLight = "SFProRounded-Light"
        case sfProRoundedMedium = "SFProRounded-Medium"
        case sfProRoundedRegular = "SFProRounded-Regular"
        case sfProRoundedSemibold = "SFProRounded-Semibold"
        case sfProRoundedThin = "SFProRounded-Thin"
        case sfProRoundedUltralight = "SFProRounded-Ultralight"
    }

    static func setFont(_ type: fontType = .sfProRoundedRegular, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        if let font = UIFont(name: type.rawValue, size: size) {
            return font
        } else {
            print("Шрифт \(type.rawValue) не найден!")
            return UIFont.systemFont(ofSize: size)
        }
    }
}
