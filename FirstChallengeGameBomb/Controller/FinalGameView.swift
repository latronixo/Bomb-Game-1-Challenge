//
//  FinalGameView.swift
//  FirstChallengeGameBomb
//
//  Created by Валентин latronixo on 09.02.2025.
//

import UIKit
import Settings

final class FinalGameViewController: BaseViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Конец игры"
        label.font = .setFont(.sfProRoundedBlack, size: 30)
        label.textColor = .PrimaryText
        label.textAlignment = .center
        return label
    }()
    
    private let gameImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "finalGameImage"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "В следующем раунде после каждого ответа хлопать в ладоши"
        label.font = .setFont(.sfProRoundedSemibold, size: 28)
        label.textColor = .PrimaryText
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let otherTaskButton: UIButton = {
        let button = UIButton(title: "Другое задание", backgroundColor: .GameViewButton)
        button.titleLabel?.font = UIFont(name: "SF Pro Display", size: 20)
        button.setTitleColor(.PrimaryText, for: .normal)
        return button
    }()
    
    private let restartButton: UIButton = {
        let button = UIButton(title: "Начать заново", backgroundColor: .GameViewButton)
        button.titleLabel?.font = UIFont(name: "SF Pro Display", size: 20)
        button.setTitleColor(.PrimaryText, for: .normal)
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [otherTaskButton, restartButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [gameImageView, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, contentStackView, buttonStackView])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 35
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        restartButton.addTarget(self, action: #selector(restartButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        descriptionLabel.preferredMaxLayoutWidth = contentStackView.frame.width
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(mainStackView)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 23),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -23),
            
            gameImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            gameImageView.heightAnchor.constraint(equalTo: gameImageView.widthAnchor),
            
            buttonStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 40),
            buttonStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -40),
            buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            otherTaskButton.heightAnchor.constraint(equalToConstant: 50),
            restartButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func restartButtonTapped() {
        if let navigationController = navigationController {
            let mainViewController = MainViewController()
            navigationController.pushViewController(mainViewController, animated: true)
        }
    }
}

// Delete before pull!!

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

extension UIColor {
    static let MainBackground = UIColor(red: 1, green: 0.82, blue: 0.37, alpha: 1)
    static let GameBackground = UIColor(red: 0.96, green: 0.96, blue: 0.93, alpha: 1)
    static let MainViewButton = UIColor(red: 0.96, green: 0.96, blue: 0.93, alpha: 1)
    static let GameViewButton = UIColor(red: 1, green: 0.82, blue: 0.37, alpha: 1)
    static let MainSheetBg = UIColor(red: 0.96, green: 0.96, blue: 0.93, alpha: 1)
    static let CategorySheetBg = UIColor(red: 1, green: 0.82, blue: 0.37, alpha: 1)
    static let CategoryCellBg = UIColor(red: 0.92, green: 0.91, blue: 0.86, alpha: 1)
    static let CategoryCellSelect = UIColor(red: 0.71, green: 1, blue: 0.65, alpha: 1)
    static let PrimaryText = UIColor(red: 0.24, green: 0.23, blue: 0.23, alpha: 1)
    static let SecondaryText = UIColor(red: 0.96, green: 0.96, blue: 0.93, alpha: 1)
 }

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
