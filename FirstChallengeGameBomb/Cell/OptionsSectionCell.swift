//
//  OptionCell.swift
//  FirstChallengeGameBomb
//
//  Created by Надежда Капацина on 15.02.2025.
//

import UIKit

final class OptionsSectionCell: UICollectionViewCell {
    static let reuseIdentifier = "OptionsSectionCell"
    private var settings = SettingsBrain()
    
    // MARK: - UI Elements
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 15
        stack.distribution = .fillEqually
        return stack
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
//        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stackView.subviews.forEach { $0.removeFromSuperview()}
    }
    
    // MARK: - Setup
    public func setupUI(selector: Selector) {
        contentView.layer.cornerRadius = 15
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.backgroundColor = .settingsCell
        
        // Добавляем стек
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
        
        // Добавляем кнопки
        let options = ["Фоновая музыка", "Тиканье бомбы", "Взрыв бомбы"]
        for option in options {
            let button = createOptionButton(title: option, description: "\(getSubTitle(title: option))", selector: selector)
            stackView.addArrangedSubview(button)
            
            button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
    }
    
    private func getSubTitle(title: String) -> String {
        switch title {
        case "Фоновая музыка":
            return settings.backgroundMusic.first { $0.fileName == settings.backgroundMusicValue }?.title ?? "test"
        case "Тиканье бомбы":
            return settings.tickingBombMusic.first { $0.fileName == settings.tickingBombMusicValue }?.title ?? "test"
        case "Взрыв бомбы":
            return settings.bombBoomMusic.first { $0.fileName == settings.bombBoomMusicValue }?.title ?? "test"
        default:
            return ""
        }
    }

    
    private func createOptionButton(title: String, description: String, selector: Selector) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.backgroundColor = .settingsBlack
        button.titleLabel?.font = .setFont(.sfProRoundedBlack, size: 18)
        button.layer.cornerRadius = 15
        button.setTitleColor(.white, for: .normal)
        button.contentHorizontalAlignment = .left
        button.addTarget(nil, action: selector, for: .touchUpInside)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        
        // Добавляем стрелочку
        let arrowImageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        arrowImageView.tintColor = .gray
        button.addSubview(arrowImageView)
        
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            arrowImageView.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -10),
            arrowImageView.centerYAnchor.constraint(equalTo: button.centerYAnchor)
        ])
        
        // Добавляем название выбранного звука
        let soundName = UILabel()
        soundName.text = "\(description)"
        soundName.textColor = .settingsSelectedSound
        button.addSubview(soundName)
        
        soundName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            soundName.rightAnchor.constraint(equalTo: arrowImageView.leftAnchor, constant: -4),
            soundName.centerYAnchor.constraint(equalTo: button.centerYAnchor)
        ])
        
        return button
    }

}
