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
    
    private let tasks = [
        "В следующем раунде говорить шёпотом",
        "В следующем раунде отвечать с закрытыми глазами",
        "В следующем раунде после ответа хлопать в ладоши",
        "В следующем раунде говорить как робот",
        "В следующем раунде отвечать на вопросы песней",
        "В следующем раунде нельзя говорить 'да' и 'нет'",
        "В следующем раунде говорить быстро, как аукционист",
        "В следующем раунде отвечать только вопросами",
        "В следующем раунде на каждое слово показывать жестом",
        "В следующем раунде отвечать только односложными словами"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        restartButton.addTarget(self, action: #selector(restartButtonTapped), for: .touchUpInside)
        otherTaskButton.addTarget(self, action: #selector(otherTaskButtonTapped), for: .touchUpInside)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(gameImageView)
        view.addSubview(descriptionLabel)
        view.addSubview(otherTaskButton)
        view.addSubview(restartButton)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        gameImageView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        otherTaskButton.translatesAutoresizingMaskIntoConstraints = false
        restartButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            gameImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            gameImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gameImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            gameImageView.heightAnchor.constraint(equalTo: gameImageView.widthAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: gameImageView.bottomAnchor, constant: 34),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            restartButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            restartButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 23),
            restartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -23),
            restartButton.heightAnchor.constraint(equalToConstant: 55),
            
            otherTaskButton.bottomAnchor.constraint(equalTo: restartButton.topAnchor, constant: -16),
            otherTaskButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 23),
            otherTaskButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -23),
            otherTaskButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    @objc private func restartButtonTapped() {
        if let navigationController = navigationController {
            let mainViewController = MainViewController()
            navigationController.pushViewController(mainViewController, animated: true)
        }
    }
    
    @objc private func otherTaskButtonTapped() {
        descriptionLabel.text = tasks.randomElement()
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
