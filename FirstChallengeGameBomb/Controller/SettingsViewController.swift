import UIKit

protocol SettingsViewControllerDelegate: AnyObject {
    func reloadSettings()
}

class SettingViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
    
    private var settingsBrain = SettingsBrain()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
        setupNavigation()
    }
    
    private func setupUI() {
        view.addSubview(backgroundImage)
        setupCollectionView()
        
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
        
    }
    private func setupCollectionView() {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createLayout(for: sectionIndex)
        }
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        
        // Регистрация ячеек
        collectionView.register(SpeedSectionCell.self, forCellWithReuseIdentifier: SpeedSectionCell.reuseIdentifier)
        collectionView.register(OptionsSectionCell.self, forCellWithReuseIdentifier: OptionsSectionCell.reuseIdentifier)
        collectionView.register(SwitchesSectionCell.self, forCellWithReuseIdentifier: SwitchesSectionCell.reuseIdentifier)
        
        view.addSubview(collectionView)
    }
    
    private func createLayout(for section: Int) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(section == 0 ? 200 : 150)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(section == 0 ? 200 : 150)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = 10
        
        return section
    }
    
    // MARK: - Navigation
    
    private func setupNavigation() {
        
        title = "Настройки"
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.setFont(.sfProRoundedBlack, size: 28),
            .foregroundColor: UIColor.PrimaryText
        ]
            
        navigationController?.navigationBar.titleTextAttributes = attributes
        
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(backToMainScreen)
        )
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton

}
    
    // MARK: - Actions
    
    @objc func backToMainScreen() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func goSelectSound(_ sender: UIButton) {        
        let musicSelectionVC = MusicSelectionViewController()
        musicSelectionVC.delegate = self
        
        switch sender.titleLabel?.text {
        case "Фоновая музыка":
            musicSelectionVC.musics = settingsBrain.backgroundMusic
            musicSelectionVC.musicType = .backgroundMusic
        case "Тиканье бомбы":
            musicSelectionVC.musics = settingsBrain.tickingBombMusic
            musicSelectionVC.musicType = .soundTickingBomb
        case "Взрыв бомбы":
            musicSelectionVC.musics = settingsBrain.bombBoomMusic
            musicSelectionVC.musicType = .soundBombBoom
        default:
            break
        }
        
        navigationController?.pushViewController(musicSelectionVC, animated: true)
    }
    
}
// MARK: - UICollectionViewDataSource
extension SettingViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SpeedSectionCell.reuseIdentifier,
                for: indexPath
            ) as! SpeedSectionCell
            
            // Обновляем состояние кнопок при загрузке
            cell.updateSelectedButton(index: settingsBrain.selectedTime)
            
            // Передаем выбранное время в SettingsBrain
            cell.onTimeSelected = { [weak self] index in
                self?.settingsBrain.selectedTime = index
            }
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: OptionsSectionCell.reuseIdentifier,
                for: indexPath
            ) as! OptionsSectionCell
            cell.setupUI(selector: #selector(goSelectSound))
            return cell
            
        case 2:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SwitchesSectionCell.reuseIdentifier,
                for: indexPath
            ) as! SwitchesSectionCell
            return cell
            
        default:
            fatalError("Неизвестная секция")
        }
    }
}

extension SettingViewController: SettingsViewControllerDelegate {
    func reloadSettings() {
        print("test reloadSettings")
        collectionView.reloadData()
    }
}
