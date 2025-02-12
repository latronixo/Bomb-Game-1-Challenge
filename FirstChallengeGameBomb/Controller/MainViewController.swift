//
//  ViewController.swift
//  FirstChallengeGameBomb
//
//  Created by Валентин latronixo on 09.02.2025.
//

import UIKit
import Settings

class MainViewController: BaseViewController {

    private let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
    
    private lazy var firstTitleLabel: UILabel = {
        let element = UILabel()
        element.text = "ИГРА ДЛЯ КОМПАНИИ"
        element.textAlignment = .center
        element.font = .setFont(.sfProRoundedBlack, size: 32)
        element.textAlignment = .center
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    } ()
    
    private lazy var secondTitleLabel: UILabel = {
        let element = UILabel()
        element.text = "БОМБА"
        element.textAlignment = .center
        element.font = .setFont(.sfProRoundedBlack, size: 50)
        element.textAlignment = .center
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    } ()
    
    private let bombMainImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bombMainScreen")
        imageView.contentMode = .scaleAspectFill
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let startGameButton = UIButton(title: "Старт игры", backgroundColor: UIColor(red: 245/255, green: 244/255, blue: 238/255, alpha: 1.00))

    private let categoriesButton = UIButton(title: "Категории", backgroundColor: UIColor(red: 245/255, green: 244/255, blue: 238/255, alpha: 1.00))

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigation()
        setupConstraints()
        
        startGameButton.addTarget(self, action: #selector(startGameButtonTapped), for: .touchUpInside)
        categoriesButton.addTarget(self, action: #selector(categoriesButtonTapped), for: .touchUpInside)
    }

    private func setupUI () {
        [backgroundImage, firstTitleLabel, secondTitleLabel, bombMainImage, startGameButton, categoriesButton]
            .forEach({ view.addSubview($0) })

        backgroundImage.image = UIImage(named: "backgroundMainScreen")
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false

        view.backgroundColor = .appYellowMainView
        
    }
    
    //MARK: - Contstraints
    
    private func setupConstraints () {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
 
            firstTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            firstTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            secondTitleLabel.topAnchor.constraint(equalTo: firstTitleLabel.bottomAnchor, constant: 12),
            secondTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            bombMainImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bombMainImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            bombMainImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.76),
            bombMainImage.heightAnchor.constraint(equalTo: bombMainImage.widthAnchor),

            //кнопка Старт игры
            startGameButton.topAnchor.constraint(equalTo: bombMainImage.bottomAnchor, constant: 75),
            startGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startGameButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            startGameButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07),

            //кнопка Категории
            categoriesButton.topAnchor.constraint(equalTo: startGameButton.bottomAnchor, constant: 10),
            categoriesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            categoriesButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            categoriesButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07)

        ])
    }

    // MARK: - Navigation
    
    private func setupNavigation() {
        let settingsButton = UIBarButtonItem(
            image: UIImage(systemName: "transmission"),
            style: .plain,
            target: self,
            action: #selector(settingsScreen)
        )
        settingsButton.tintColor = .black
        navigationItem.leftBarButtonItem = settingsButton
    
        let questionButton = UIBarButtonItem(
            image: UIImage(systemName: "questionmark.circle.fill"),
            style: .plain,
            target: self,
            action: #selector(goToHelpVC)
        )
    
        questionButton.tintColor = .appRed
        navigationItem.rightBarButtonItem = questionButton
}
    
    // MARK: - Actions
    
    @objc func settingsScreen() {
//        let settingsVC = SettingsView()
//        navigationController?.pushViewController(settingsVC, animated: true)
    }

    @objc func goToHelpVC() {
        let helpVC = HelpCaregoryViewController()
        navigationController?.pushViewController(helpVC, animated: true)
    }

    @objc private func startGameButtonTapped () {
//        let gameVC = GameView()
//        navigationController?.pushViewController(settingsVC, animated: true)
    }

    @objc private func categoriesButtonTapped () {
        let categoriesVC = CategoriesViewController()
        navigationController?.pushViewController(categoriesVC, animated: true)
    }

}
