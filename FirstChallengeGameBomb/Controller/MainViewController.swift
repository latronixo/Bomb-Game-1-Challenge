//
//  ViewController.swift
//  FirstChallengeGameBomb
//
//  Created by Валентин latronixo on 09.02.2025.
//

import UIKit
import Settings

class MainViewController: BaseViewController {

    //private let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
    
    private lazy var mainStackView: UIStackView = {
        let element = UIStackView()
        element.spacing = 80
        element.distribution = .fillEqually
        element.axis = .vertical
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    } ()
    
    private lazy var firstTitleLabel: UILabel = {
        let element = UILabel()
        element.text = "ИГРА ДЛЯ КОМПАНИИ"
        element.textAlignment = .center
        element.font = .systemFont(ofSize: 25)
        element.textAlignment = .center
        
        //выделим рамкой (для отладки)
        element.layer.borderWidth = 2.0
        element.layer.borderColor = UIColor.red.cgColor
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    } ()
    
    private lazy var secondTitleLabel: UILabel = {
        let element = UILabel()
        element.text = "БОМБА"
        element.textAlignment = .center
        element.font = .systemFont(ofSize: 40, weight: .bold)
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
        
    }

    private func setupUI () {
      
        view.backgroundColor = .appYellowMainView

        
        //создаем главный вертикальный стек
        view.addSubview(mainStackView)
        
        //в главный вертикальный стек добавляем элементы
        mainStackView.addArrangedSubview(firstTitleLabel)
        mainStackView.addArrangedSubview(secondTitleLabel)
        mainStackView.addArrangedSubview(bombMainImage)
        mainStackView.addArrangedSubview(startGameButton)
        mainStackView.addArrangedSubview(categoriesButton)

        
//        view.addSubview(startGameButton)
//        view.addSubview(categoriesButton)
        
        startGameButton.addTarget(self, action: #selector(startGameButtonTapped), for: .touchUpInside)
        categoriesButton.addTarget(self, action: #selector(categoriesButtonTapped), for: .touchUpInside)

//        NSLayoutConstraint.activate([
//
//            
//        ])
    }
    
    //MARK: - Contstraints
    
    private func setupConstraints () {
        NSLayoutConstraint.activate([
//            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
//            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            //главный вертикальный стек прикрепляем в safeArea, справа и слева только делаем отступы по 20
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            //закрепляем firstTitleLabel в центре mainStackView
            firstTitleLabel.topAnchor.constraint(equalTo: mainStackView.topAnchor, constant: 200),
            firstTitleLabel.centerYAnchor.constraint(equalTo: mainStackView.centerYAnchor),
            firstTitleLabel.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            firstTitleLabel.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            
            //закрепляем secondTitleLabel в центре mainStackView
            secondTitleLabel.topAnchor.constraint(equalTo: firstTitleLabel.bottomAnchor, constant: 5),
            secondTitleLabel.centerYAnchor.constraint(equalTo: mainStackView.centerYAnchor),
            secondTitleLabel.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            secondTitleLabel.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            
            //картинку с изображением бомбы крепим к слову бомба
            bombMainImage.topAnchor.constraint(equalTo: secondTitleLabel.bottomAnchor),
            bombMainImage.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            bombMainImage.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),

            //кнопка Старт игры
            startGameButton.heightAnchor.constraint(equalToConstant: 10),
            startGameButton.bottomAnchor.constraint(equalTo: categoriesButton.topAnchor),
            startGameButton.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 10),
            startGameButton.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -10),

            //кнопку Категории крепим к нижней части mainStackView
            categoriesButton.heightAnchor.constraint(equalToConstant: 10),
            categoriesButton.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor),
            categoriesButton.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 10),
            categoriesButton.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -10),

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
