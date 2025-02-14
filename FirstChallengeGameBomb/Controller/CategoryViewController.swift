//
//  CategoryView.swift
//  FirstChallengeGameBomb
//
//  Created by Валентин latronixo on 09.02.2025.
//

import UIKit
import Settings

class CategoriesViewController: UIViewController {
    
    @UserDefault(key: "selectedCategories", defaultValue: [])
    private var selectedCategories: [String]
    
    private let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
    private let slideUpTransitioningDelegate = SlideUpTransitioningDelegate()
    private var categories: [Category] = [
        Category(name: "О Разном", imageName: "smileSquare", isSelected: false),
        Category(name: "Спорт и Хобби", imageName: "sport", isSelected: false),
        Category(name: "Про Жизнь", imageName: "message", isSelected: false),
        Category(name: "Знаменитости", imageName: "star", isSelected: false),
        Category(name: "Искусство и Кино", imageName: "cinema", isSelected: false),
        Category(name: "Природа", imageName: "nature", isSelected: false)
    ]
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 23
        layout.minimumInteritemSpacing = 23
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigation()
        collectionView.allowsMultipleSelection = true
        
        // Восстановление выбранных категорий
         for (index, category) in categories.enumerated() {
             if selectedCategories.contains(category.name) {
                 categories[index].isSelected = true
             }
         }
    }
    
    private func setupUI() {
        title = "Категории"
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
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 23),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -23),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - Navigation
    
    private func setupNavigation() {
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(backToMainScreen)
        )
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
        
        let questionButton = UIBarButtonItem(
            image: UIImage(systemName: "questionmark.circle.fill"),
            style: .plain,
            target: self,
            action: #selector(showHelpVC)
        )
        questionButton.tintColor = .appYellow
        navigationItem.rightBarButtonItem = questionButton
    }
    
    // MARK: - Actions
    
    @objc func backToMainScreen() {
        navigationController?.popViewController(animated: true)
    }
    @objc private func showHelpVC() {
        let helpVC = HelpCaregoryViewController()
        helpVC.modalPresentationStyle = .custom
        helpVC.transitioningDelegate = slideUpTransitioningDelegate
        present(helpVC, animated: true)
        
    }
}
    // MARK: - CollectionView DataSource и Delegate
    extension CategoriesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            categories.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoryCell.identifier,
                for: indexPath
            ) as! CategoryCell
            
            cell.configure(with: categories[indexPath.row])
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = (collectionView.frame.width - 32) / 2
            return CGSize(width: width, height: 150)
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            categories[indexPath.row].isSelected.toggle()
            collectionView.reloadItems(at: [indexPath])
            
            // Обновление массива выбранных категорий
            let category = categories[indexPath.row]
            if category.isSelected {
                selectedCategories.append(category.name)
            } else {
                selectedCategories.removeAll { $0 == category.name }
            }
            
            // Анимация нажатия
            if let cell = collectionView.cellForItem(at: indexPath) {
                UIView.animate(withDuration: 0.1, animations: {
                    cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                }) { _ in
                    UIView.animate(withDuration: 0.1) {
                        cell.transform = .identity
                    }
                }
            }
        }
        
    }
