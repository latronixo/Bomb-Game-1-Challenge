//
//  FinalGameView.swift
//  FirstChallengeGameBomb
//
//  Created by Валентин latronixo on 09.02.2025.
//

import UIKit
import Settings

final class FinalGameViewController: BaseViewController {
    
    private var lastTaskIndex: Int?
    
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
        button.titleLabel?.font = .setFont(.sfProRoundedMedium, size: 20)
        button.setTitleColor(.PrimaryText, for: .normal)
        return button
    }()
    
    private let restartButton: UIButton = {
        let button = UIButton(title: "Начать заново", backgroundColor: .GameViewButton)
        button.titleLabel?.font = .setFont(.sfProRoundedMedium, size: 20)
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
        navigationController?.popToRootViewController(animated: true)
    }

    @objc private func otherTaskButtonTapped() {
        var newIndex: Int
        repeat {
            newIndex = Int.random(in: 0..<tasks.count)
        } while newIndex == lastTaskIndex
        lastTaskIndex = newIndex
        descriptionLabel.text = tasks[newIndex]
    }
}
