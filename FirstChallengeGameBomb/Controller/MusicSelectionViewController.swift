//
//  MusicSelectionViewController.swift
//  FirstChallengeGameBomb
//
//  Created by Александр Пеньков on 15.02.2025.
//

import UIKit


class MusicSelectionViewController: UIViewController {
    
    weak var delegate: SettingsViewControllerDelegate?
    
    public var musicType: MusicType = .backgroundMusic
    public var musics: [Settings.Music] = []
    private var settings = SettingsBrain()
    private var selectedMusic: String = ""
    private let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
    private let collectionMusicView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        layout.minimumLineSpacing = 30
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(MusicSelectionCell.self, forCellWithReuseIdentifier: "MusicSelectionCell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionMusicView.delegate = self
        collectionMusicView.dataSource = self
        
        switch musicType {
        case .backgroundMusic:
            selectedMusic = settings.getBackgroundMusic()
        case .soundTickingBomb:
            selectedMusic = settings.getSoundTickingBomb()
        case .soundBombBoom:
            selectedMusic = settings.getSoundBombBoom()
        }
        
        configureUI()
        setupNavigation()
    }
    
    private func configureUI() {
        view.addSubview(backgroundImage)
        view.backgroundColor = .white
        backgroundImage.image = UIImage(named: "Topographic 3")
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.addSubview(collectionMusicView)
        collectionMusicView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 6).isActive = true
        collectionMusicView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        collectionMusicView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        collectionMusicView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    // MARK: - Navigation
    
    private func setupNavigation() {
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(backToSettingsScreen)
        )
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
    }
    
    // MARK: - Actions
    
    @objc func backToSettingsScreen() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func setMusic(_ sender: UIButton) {
        if let music = musics.first(where: { $0.title == "\(sender.titleLabel?.text ?? "")" }) {
            switch musicType {
                case .backgroundMusic: settings.backgroundMusicValue = music.fileName
                case .soundBombBoom: settings.bombBoomMusicValue = music.fileName
                case .soundTickingBomb: settings.tickingBombMusicValue = music.fileName
            }
            
            selectedMusic = music.fileName
            
            switch musicType {
            case .backgroundMusic:
                settings.backgroundMusicValue = music.fileName
            case .soundTickingBomb:
                settings.tickingBombMusicValue = music.fileName
            case .soundBombBoom:
                settings.bombBoomMusicValue = music.fileName
            }
            
            collectionMusicView.reloadData()
            delegate?.reloadSettings()
        }
    }
}


//MARK: UICollectionViewDelegate

extension MusicSelectionViewController: UICollectionViewDelegate {

}

//MARK: UICollectionViewDelegate

extension MusicSelectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return musics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MusicSelectionCell", for: indexPath) as! MusicSelectionCell
        itemCell.setupCellData(title: musics[indexPath.row].title, state: musics[indexPath.row].fileName == selectedMusic)
        itemCell.cellButton.addTarget(self, action: #selector(setMusic), for: .touchUpInside)
        return itemCell
    }
}

//MARK: UICollectionViewDelegateFlowLayout

extension MusicSelectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionMusicView.frame.width - 60 , height: 50)
    }
}
