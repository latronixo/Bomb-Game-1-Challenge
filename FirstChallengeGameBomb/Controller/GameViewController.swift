//
//  GameView.swift
//  FirstChallengeGameBomb
//
//  Created by Валентин latronixo on 09.02.2025.
//

import UIKit
import Lottie

class GameViewController: UIViewController {

    private let gameBrain = GameBrain()
    
    private let gameBackgroundView: UIImageView = {
        let view = UIImageView()
        view.isUserInteractionEnabled = true
        view.backgroundColor = .MainSheetBg
        view.image = .topographic3
        view.tintColor = UIColor(red: 0.89, green: 0.89, blue: 0.86, alpha: 1)
        view.image = view.image?.withRenderingMode(.alwaysTemplate)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let backButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.action = #selector(backButtonAction)
        button.tintColor = .PrimaryText
        button.image = UIImage(systemName: "chevron.left")
        button.style = .plain
        return button
    }()
    
    private let pauseButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.action = #selector(pauseButtonAction)
        button.tintColor = .PrimaryText
        button.image = UIImage(systemName: "pause.circle")
        button.style = .plain
        return button
    }()
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .setFont(.sfProRoundedMedium, size: 28)
        label.textColor = .PrimaryText
        label.text = "Нажмите “Запустить” чтобы начать игру"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let startGameButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .GameViewButton
        button.layer.cornerRadius = 10
        button.setTitle("Запустить", for: .normal)
        button.setTitleColor(.PrimaryText, for: .normal)
        button.titleLabel?.font = .setFont(.sfProRoundedBold, size: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let bombAnimateView: LottieAnimationView = {
        var animationView = LottieAnimationView()
        animationView = .init(name: "Animation - 1739310950383")
        animationView.contentMode = .scaleAspectFit
        animationView.animationSpeed = 0.5
        animationView.translatesAutoresizingMaskIntoConstraints = false
        return animationView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.target = self
        pauseButton.target = self
        configureUI()
    }
    

    private func configureUI() {
        let attributes = [NSAttributedString.Key.font: UIFont.setFont(.sfProRoundedBlack, size: 30)]
        UINavigationBar.appearance().titleTextAttributes = attributes
        
        title = "Игра"
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = pauseButton

        view.addSubview(gameBackgroundView)
        gameBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        gameBackgroundView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        gameBackgroundView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        gameBackgroundView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        gameBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        view.addSubview(mainLabel)
        mainLabel.topAnchor.constraint(equalTo: navigationItem.titleView?.bottomAnchor ?? view.safeAreaLayoutGuide.topAnchor, constant: 23).isActive = true
        mainLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 23).isActive = true
        mainLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -23).isActive = true
        
        view.addSubview(startGameButton)
        startGameButton.addTarget(self, action: #selector(startGameButtonAction), for: .touchUpInside)
        startGameButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 23).isActive = true
        startGameButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -23).isActive = true
        startGameButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -48).isActive = true
        startGameButton.heightAnchor.constraint(equalTo: startGameButton.widthAnchor, multiplier: 1/6).isActive = true
        
        view.addSubview(bombAnimateView)
        bombAnimateView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bombAnimateView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        bombAnimateView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
        bombAnimateView.heightAnchor.constraint(equalTo: bombAnimateView.widthAnchor, multiplier: 1.0).isActive = true
    }

    @objc func backButtonAction() {
//        navigationController?.popViewController(animated: true)
        print("backToMainScreen")
    }
    
    @objc func pauseButtonAction() {
        print("pauseButtonAction")
    }
    
    @objc func startGameButtonAction(sender: UIButton) {
        print("startGameButtonAction")
        mainLabel.text = gameBrain.getQuestionText()
        mainLabel.font = .setFont(.sfProRoundedBlack, size: 28)
        startGameButton.isHidden = true
        startLoopAnimate()
    }
    
    private func startLoopAnimate() {
        bombAnimateView.play(fromFrame: 0, toFrame: 12, loopMode: .loop)
    }
}
