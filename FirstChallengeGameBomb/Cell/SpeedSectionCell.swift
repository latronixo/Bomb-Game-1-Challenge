//
//  ButtonCell.swift
//  FirstChallengeGameBomb
//
//  Created by Надежда Капацина on 15.02.2025.
//

import UIKit

final class SpeedSectionCell: UICollectionViewCell {
    static let reuseIdentifier = "RulesSectionCell"
    var onTimeSelected: ((Int) -> Void)?
    
    // MARK: - UI Elements
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "ВРЕМЯ ИГРЫ"
        label.font = .setFont(.sfProRoundedHeavy, size: 20)
        label.textAlignment = .left
        return label
    }()
    
    private let buttonsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        return stack
    }()
    
    private var buttons: [UIButton] = []
    
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
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.backgroundColor = .settingsCell
        
        // Добавляем элементы
        contentView.addSubview(titleLabel)
        contentView.addSubview(buttonsStack)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        buttonsStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            buttonsStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            buttonsStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            buttonsStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            buttonsStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            buttonsStack.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        // Создаем кнопки
        let firstRow = createButtonRow(titles: ["Короткое", "Среднее"])
        let secondRow = createButtonRow(titles: ["Длинное", "Случайное"])
        
        buttonsStack.addArrangedSubview(firstRow)
        buttonsStack.addArrangedSubview(secondRow)
    }
    
    private func createButtonRow(titles: [String]) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 40
        stack.distribution = .fillEqually
        
        for title in titles {
            let button = UIButton()
            button.setTitle(title, for: .normal)
            button.backgroundColor = .settingsBlack
            button.titleLabel?.font = .setFont(.sfProRoundedBlack, size: 18)
            button.layer.cornerRadius = 15
            button.setTitleColor(.white, for: .normal)
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            stack.addArrangedSubview(button)
            buttons.append(button)
        }
        
        return stack
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        for button in buttons {
                    button.backgroundColor = .settingsBlack
                }
        sender.backgroundColor = .appYellow
                
                if let index = buttons.firstIndex(of: sender) {
                    onTimeSelected?(index)
                }
    }
    func updateSelectedButton(index: Int) {
        for (i, button) in buttons.enumerated() {
            button.backgroundColor = (i == index) ? .appYellow : .settingsBlack
        }
    }
}
