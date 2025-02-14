//
//  GameView.swift
//  FirstChallengeGameBomb
//
//  Created by Валентин latronixo on 09.02.2025.
//

import UIKit
import Lottie
import AVFoundation

class GameViewController: UIViewController {

    private var gameBrain = GameBrain()
    private var timer: Timer?
    private var runCountTimer = 30
    private var playerSound: AVAudioPlayer?
    private var playerMusic: AVAudioPlayer?

    
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
        animationView = .init(name: "Animation - 1739445823982")
        animationView.contentMode = .scaleAspectFit
        animationView.animationSpeed = 1
        animationView.loopMode = .loop
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
        title = "Игра"
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.setFont(.sfProRoundedBlack, size: 28)
        ]
            
        navigationController?.navigationBar.titleTextAttributes = attributes
        
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
    
    // MARK: - Кнопки в UI

    @objc func backButtonAction() {
        stopAllFunc()
        navigationController?.popViewController(animated: true)
    }
    
    @objc func pauseButtonAction() {
        if timer != nil {
            stopTimer()
            stopBombSound()
            stopMusic()
        } else {
            startTimer()
            playBombSound()
            playMusic()
        }
    }
    
    @objc func startGameButtonAction(sender: UIButton) {
        mainLabel.text = gameBrain.getQuestionText()
        mainLabel.font = .setFont(.sfProRoundedBlack, size: 28)
        startGameButton.isHidden = true
        startLoopAnimate()
        startTimer()
        playBombSound()
        playMusic()
    }
    
    // MARK: - Работа с таймером
    
    @objc func updateTimer() {
        runCountTimer -= 1
        
        if runCountTimer == 0 {
            finishTime()
        }
    }
    
    private func startTimer() {
        if timer == nil {
          let timer = Timer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
          RunLoop.current.add(timer, forMode: .common)
          timer.tolerance = 0.1
          self.timer = timer
        }
        
        if bombAnimateView.isAnimationPlaying == false {
            startLoopAnimate()
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
        if runCountTimer > 0 {
            self.bombAnimateView.stop()
        }
    }
    
    // MARK: - Работа с анимацией
    
    private func startLoopAnimate() {
        bombAnimateView.play()
    }
    
    // MARK: - Работа со звуком бомбы
    
    func playBombSound() {
        let url = Bundle.main.url(forResource: "tikane-taymera-bombyi", withExtension: "mp3")
        playerSound = try! AVAudioPlayer(contentsOf: url!)
        playerSound?.numberOfLoops =  -1
        playerSound?.play()
    }
    
    func stopBombSound() {
        playerSound?.stop()
    }
    
    
    // MARK: - Работа с фоновой музыкой
    
    func playMusic() {
        let url = Bundle.main.url(forResource: "muzyika-dlya-sna-relaks", withExtension: "mp3")
        playerMusic = try! AVAudioPlayer(contentsOf: url!)
        playerMusic?.numberOfLoops =  -1
        playerMusic?.play()
    }
    
    func stopMusic() {
        playerMusic?.stop()
    }
    
    // MARK: - Конец игры
    
    private func finishTime() {
        stopAllFunc()
        let FinalGameVC = FinalGameViewController()
        navigationController?.pushViewController(FinalGameVC, animated: true)
    }
    
    private func stopAllFunc() {
        stopTimer()
        stopBombSound()
        stopMusic()
        bombAnimateView.stop()
    }
}
