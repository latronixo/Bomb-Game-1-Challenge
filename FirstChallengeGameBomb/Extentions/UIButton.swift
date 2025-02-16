//
//  UIButton.swift
//  FirstChallengeGameBomb
//
//  Created by Валентин Картошкин on 10.02.2025.
//

import UIKit

extension UIButton {
    convenience init(title: String, backgroundColor: UIColor) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        self.tintColor = UIColor(named: "TextColor")
        self.setTitleColor(UIColor(red: 0.24, green: 0.23, blue: 0.23, alpha: 1), for: .normal)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = 12
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.gray.cgColor
            
        self.translatesAutoresizingMaskIntoConstraints = false
        
    }
}
