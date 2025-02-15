//
//  FinalGameView.swift
//  FirstChallengeGameBomb
//
//  Created by Валентин latronixo on 09.02.2025.
//

import UIKit
import Settings
import AVFoundation

final class FinalGameViewController: BaseViewController {
    
    private var lastTaskIndex: Int?
    private var playerMusic: AVAudioPlayer?
    
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
        navigationItem.hidesBackButton = true
        restartButton.addTarget(self, action: #selector(restartButtonTapped), for: .touchUpInside)
        otherTaskButton.addTarget(self, action: #selector(otherTaskButtonTapped), for: .touchUpInside)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        playMusic()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        let buttonsStackView = UIStackView(arrangedSubviews: [otherTaskButton, restartButton])
        buttonsStackView.axis = .vertical
        buttonsStackView.spacing = 16
        buttonsStackView.alignment = .fill
        
        view.addSubview(titleLabel)
        view.addSubview(gameImageView)
        view.addSubview(descriptionLabel)
        view.addSubview(buttonsStackView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        gameImageView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -10),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            gameImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            gameImageView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.4),  
            gameImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gameImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 57),
            gameImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -57),
            
            descriptionLabel.topAnchor.constraint(equalTo: gameImageView.bottomAnchor, constant: 34),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            buttonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 23),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -23),
            
            otherTaskButton.heightAnchor.constraint(equalToConstant: 55),
            restartButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    @objc private func restartButtonTapped() {
        let gameViewController = GameViewController()
        navigationController?.pushViewController(gameViewController, animated: true)
    }
    
    @objc private func otherTaskButtonTapped() {
        var newIndex: Int
        repeat {
            newIndex = Int.random(in: 0..<tasks.count)
        } while newIndex == lastTaskIndex
        lastTaskIndex = newIndex
        descriptionLabel.text = tasks[newIndex]
    }
    
    private func playMusic() {
        guard let url = Bundle.main.url(forResource: "Boom", withExtension: "mp3") else { return }
        do {
            playerMusic = try AVAudioPlayer(contentsOf: url)
            playerMusic?.play()
        } catch {
            print("Ошибка воспроизведения звука: \(error.localizedDescription)")
        }
    }
}
