//
//  Untitled.swift
//  FirstChallengeGameBomb
//
//  Created by Надежда Капацина on 15.02.2025.
//
import UIKit

final class SwitchesSectionCell: UICollectionViewCell {
    static let reuseIdentifier = "SwitchesSectionCell"
    
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
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupUI() {
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
        
        // Добавляем кнопки с переключателями
        let options = ["Вибрация", "Игра с заданиями"]
        for option in options {
            let button = createSwitchButton(title: option)
            stackView.addArrangedSubview(button)
            
            // Устанавливаем фиксированную высоту для кнопки
            button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
    }
    
    private func createSwitchButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .setFont(.sfProRoundedBlack, size: 16)
        button.layer.cornerRadius = 15
        button.backgroundColor = .settingsBlack
        button.contentHorizontalAlignment = .left
        
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        
        // Добавляем переключатель
        let switchControl = UISwitch()
        switchControl.isOn = true
        switchControl.onTintColor = .appYellow
        switchControl.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        button.addSubview(switchControl)
        
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            switchControl.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -10),
            switchControl.centerYAnchor.constraint(equalTo: button.centerYAnchor)
        ])
        
        return button
    }
    
    @objc private func switchValueChanged(_ sender: UISwitch) {
        print("Переключатель \(sender.isOn ? "включен" : "выключен")")
    }
}
