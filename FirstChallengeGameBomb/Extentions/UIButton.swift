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
        self.titleLabel?.font = .systemFont(ofSize: 15, weight: .black)
        self.tintColor = UIColor(named: "TextColor")
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = 10
            
        self.translatesAutoresizingMaskIntoConstraints = false
        
    }
}
