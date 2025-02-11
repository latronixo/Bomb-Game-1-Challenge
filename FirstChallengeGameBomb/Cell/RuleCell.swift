//
//  RuleCell.swift
//  FirstChallengeGameBomb
//
//  Created by Александр Пеньков on 10.02.2025.
//

import UIKit

class RuleCell: UICollectionViewCell {
    
    private let ruleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .setFont(.sfProRoundedMedium, size: 20)
        label.numberOfLines = 0
        label.textColor = .PrimaryText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let numberView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .CategorySheetBg
        label.font = .setFont(.sfProRoundedHeavy, size: 16)
        label.numberOfLines = 0
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 15
        label.layer.masksToBounds = true
        return label
    }()
    
    private let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Старт игры", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .setFont(.sfProRoundedMedium, size: 12)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .MainViewButton
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = false
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = .init(width: -1, height: 1)
        button.layer.shadowRadius = 2
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(numberView)
        numberView.leftAnchor.constraint(equalTo: leftAnchor, constant: 6).isActive = true
        numberView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        numberView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        numberView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        numberView.addSubview(numberLabel)
        numberLabel.leftAnchor.constraint(equalTo: numberView.leftAnchor).isActive = true
        numberLabel.rightAnchor.constraint(equalTo: numberView.rightAnchor).isActive = true
        numberLabel.topAnchor.constraint(equalTo: numberView.topAnchor).isActive = true
        numberLabel.bottomAnchor.constraint(equalTo: numberView.bottomAnchor).isActive = true

        addSubview(ruleLabel)
        ruleLabel.leftAnchor.constraint(equalTo: numberView.rightAnchor, constant: 18).isActive = true
        ruleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        ruleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
    }
    
    public func configure(with text: String, number: Int, withButton: Bool) {
        ruleLabel.text = text
        numberLabel.text = "\(number)"
        
        if withButton {
            addSubview(startButton)
            startButton.topAnchor.constraint(equalTo: ruleLabel.bottomAnchor, constant: 8).isActive = true
            startButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
            startButton.heightAnchor.constraint(equalToConstant: 34).isActive = true
            startButton.widthAnchor.constraint(equalToConstant: 167).isActive = true
        }
    }
}
