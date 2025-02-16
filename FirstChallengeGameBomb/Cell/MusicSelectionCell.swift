//
//  MusicSelectionCell.swift
//  FirstChallengeGameBomb
//
//  Created by Александр Пеньков on 15.02.2025.
//

import UIKit

class MusicSelectionCell: UICollectionViewCell {
    
    public let cellButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellButton.subviews.filter { $0 is UIImageView }.forEach { $0.removeFromSuperview() }
    }
    
    private func setupViews() {
        
        addSubview(cellButton)
        cellButton.titleLabel?.font = .setFont(.sfProRoundedBlack, size: 18)
        cellButton.setTitleColor(.PrimaryText, for: .normal)
        cellButton.contentHorizontalAlignment = .left
        cellButton.layer.cornerRadius = 15
        cellButton.backgroundColor = .categoryCellBg
        cellButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        cellButton.translatesAutoresizingMaskIntoConstraints = false
        cellButton.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        cellButton.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        cellButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        cellButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func setCellSelected() {
        let element = UIImageView(image: UIImage(systemName: "checkmark.circle.fill"))
        element.tintColor = .PrimaryText
        cellButton.addSubview(element)
        
        element.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            element.trailingAnchor.constraint(equalTo: cellButton.trailingAnchor, constant: -10),
            element.centerYAnchor.constraint(equalTo: cellButton.centerYAnchor)
        ])
    }
    
    public func setupCellData(title: String, state: Bool) {
        cellButton.setTitle(title, for: .normal)
        if state == true {
            setCellSelected()
        }
    }
    
}
