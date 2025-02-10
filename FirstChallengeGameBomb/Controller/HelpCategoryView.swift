//
//  HelpCategoryView.swift
//  FirstChallengeGameBomb
//
//  Created by Валентин latronixo on 09.02.2025.
//

import UIKit

class HelpCaregoryViewController: UIViewController {
    
    
    // MARK: - UI Elements
    private let backgroundImage = UIImageView()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
   
    
    private let rulesLabel: UILabel = {
        let label = UILabel()
        label.text = "Правила игры:"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rulesDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = """
        В игре доступно 6 
        категорий и более 90
        вопросов
        """
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let categoriesLabel: UILabel = {
        let label = UILabel()
        label.text = """
        Можно выбрать сразу 
        несколько категорий
        для игры
        """
        label.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private var categories: [Category] = [
        Category(name: "O Разном", imageName: "smileSquare", isSelected: false),
        Category(name: "Спорт и Хобби", imageName: "sport", isSelected: false),
        Category(name: "Про Жизнь", imageName: "message", isSelected: false),
        Category(name: "Знаменитости", imageName: "star", isSelected: false)
    ]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        backgroundImage.image = UIImage(named: "Topographic 3")
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        
        // Настройка ScrollView
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = false
        scrollView.backgroundColor = .appYellow.withAlphaComponent(0.8)
        //scrollView.backgroundColor = .appYellow
        scrollView.layer.cornerRadius = 30
        scrollView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        contentView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(scrollView)
        
        scrollView.addSubview(backgroundImage)
        scrollView.addSubview(contentView)

        // Добавление элементов в contentView
        contentView.addSubview(rulesLabel)
        contentView.addSubview(rulesDescriptionLabel)
        contentView.addSubview(categoriesLabel)
        contentView.addSubview(collectionView)

        
        // Настройка CollectionView
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsSelection = false
        
        // Констрейнты
        NSLayoutConstraint.activate([
            
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            rulesLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            rulesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            rulesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            rulesDescriptionLabel.topAnchor.constraint(equalTo: rulesLabel.bottomAnchor, constant: 20),
            rulesDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            rulesDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            categoriesLabel.topAnchor.constraint(equalTo: rulesDescriptionLabel.bottomAnchor, constant: 30),
            categoriesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            categoriesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            collectionView.topAnchor.constraint(equalTo: categoriesLabel.bottomAnchor, constant: 30),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            collectionView.heightAnchor.constraint(equalToConstant: 350),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        view.addGestureRecognizer(panGesture)
    }
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        
        switch gesture.state {
        case .changed:
            if translation.y > 0 {
                view.transform = CGAffineTransform(translationX: 0, y: translation.y)
            }
        case .ended:
            if translation.y > view.frame.height * 0.3 || velocity.y > 1000 {
                dismiss(animated: true)
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.view.transform = .identity
                }
            }
        default:
            break
        }
    }
}

// MARK: - UICollectionView DataSource & Delegate
extension HelpCaregoryViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
        cell.configureForHelpVC(with: categories[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 16) / 2
        return CGSize(width: width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        categories[indexPath.item].isSelected.toggle()
        collectionView.reloadItems(at: [indexPath])
    }
    
}


