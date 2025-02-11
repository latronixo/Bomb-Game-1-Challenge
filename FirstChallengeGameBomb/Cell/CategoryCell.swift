//
//  CategoryCell.swift
//  FirstChallengeGameBomb
//
//  Created by Надежда Капацина on 09.02.2025.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    static let identifier = "CategoryCell"
    
    // MARK: - UI elements

    private let imageView: UIImageView = {
        let element = UIImageView()
        element.contentMode = .scaleAspectFit
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let cathergoryLabel: UILabel = {
        let element = UILabel()
        element.textAlignment = .center
        element.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        element.numberOfLines = 0
        element.textColor = .black
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let checkmarkView: UIImageView = {
        let element = UIImageView(image: UIImage(systemName: "checkmark.circle.fill"))
        element.tintColor = .black
        element.isHidden = true
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let selectionOverlay: UIView = {
        let element = UIView()
        element.backgroundColor = UIColor.greenApp.withAlphaComponent(0.1)
        element.isHidden = true
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .categoryCellBg
        layer.cornerRadius = 20
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.black.cgColor
        clipsToBounds = true
        
        addShadow()
        
        let stackView = UIStackView(arrangedSubviews: [imageView, cathergoryLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center

        
        contentView.addSubview(stackView)
        contentView.addSubview(selectionOverlay)
        contentView.addSubview(checkmarkView)

        
        stackView.translatesAutoresizingMaskIntoConstraints = false

        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -8),
            contentView.heightAnchor.constraint(equalToConstant: 150),
            contentView.widthAnchor.constraint(equalToConstant: 150),
            
            imageView.heightAnchor.constraint(equalToConstant: 80),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            
            checkmarkView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            checkmarkView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            checkmarkView.widthAnchor.constraint(equalToConstant: 24),
            checkmarkView.heightAnchor.constraint(equalToConstant: 24),
            
            selectionOverlay.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            selectionOverlay.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            selectionOverlay.topAnchor.constraint(equalTo: contentView.topAnchor),
            selectionOverlay.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with category: Category) {
        cathergoryLabel.text = category.name
        imageView.image = UIImage(named: category.imageName)
        updateSelectionState(isSelected: category.isSelected)
    }
    
    func configureForHelpVC(with category: Category) {
        cathergoryLabel.text = category.name
        imageView.image = UIImage(named: category.imageName)
        updateSelectionState(isSelected: false)
        checkmarkView.isHidden = false
        
    }
    
    private func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 5
    }
    
    func updateSelectionState(isSelected: Bool) {
        checkmarkView.isHidden = !isSelected
        selectionOverlay.isHidden = !isSelected
        backgroundColor = isSelected ? .greenApp : .categoryCellBg
        cathergoryLabel.textColor = .black
        
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
    }
}
