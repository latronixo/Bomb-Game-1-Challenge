//
//  RulesView.swift
//  FirstChallengeGameBomb
//
//  Created by Валентин latronixo on 09.02.2025.
//

import UIKit

class RulesViewController: UIViewController {
    
    private let rulesModel = RulesModel()
    private var panGesture = UIPanGestureRecognizer()

    private let backgroundCloseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let separatorView: UIView = {
        let view = UIImageView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let rulesBackgroundView: UIImageView = {
        let view = UIImageView()
        view.isUserInteractionEnabled = true
        view.backgroundColor = .MainSheetBg
        view.image = .topographic3
        view.tintColor = UIColor(red: 1, green: 0.93, blue: 0.75, alpha: 1)
        view.image = view.image?.withRenderingMode(.alwaysTemplate)
        view.clipsToBounds = true
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let ruleTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .setFont(.sfProRoundedBlack, size: 32)
        label.textColor = .PrimaryText
        label.text = "Правила игры"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let collectionRulesView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        layout.minimumLineSpacing = 30
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(RuleCell.self, forCellWithReuseIdentifier: "RuleCell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        collectionRulesView.delegate = self
        collectionRulesView.dataSource = self
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        configureUI()
    }
    
    private func configureUI() {
        view.addSubview(backgroundCloseButton)
        backgroundCloseButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        backgroundCloseButton.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        backgroundCloseButton.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        backgroundCloseButton.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundCloseButton.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true

        view.addSubview(rulesBackgroundView)
        rulesBackgroundView.addGestureRecognizer(panGesture)
        rulesBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        rulesBackgroundView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        rulesBackgroundView.leftAnchor.constraint(equalTo:view.leftAnchor, constant: 0).isActive = true
        rulesBackgroundView.rightAnchor.constraint(equalTo:view.rightAnchor, constant: 0).isActive = true
        rulesBackgroundView.bottomAnchor.constraint(equalTo:view.bottomAnchor, constant: 0).isActive = true

        view.addSubview(separatorView)
        separatorView.topAnchor.constraint(equalTo: rulesBackgroundView.topAnchor, constant: 15).isActive = true
        separatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 4).isActive = true
        separatorView.widthAnchor.constraint(equalToConstant: 70).isActive = true

        view.addSubview(ruleTitleLabel)
        ruleTitleLabel.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 6).isActive = true
        ruleTitleLabel.leftAnchor.constraint(equalTo:view.leftAnchor, constant: 0).isActive = true
        ruleTitleLabel.rightAnchor.constraint(equalTo:view.rightAnchor, constant: 0).isActive = true
        ruleTitleLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true

        view.addSubview(collectionRulesView)
        collectionRulesView.topAnchor.constraint(equalTo: ruleTitleLabel.bottomAnchor, constant: 6).isActive = true
        collectionRulesView.leftAnchor.constraint(equalTo:view.leftAnchor, constant: 0).isActive = true
        collectionRulesView.rightAnchor.constraint(equalTo:view.rightAnchor, constant: 0).isActive = true
        collectionRulesView.bottomAnchor.constraint(equalTo:view.bottomAnchor, constant: 0).isActive = true
    }
    
    private func calculateTextHeight(text: String, font: UIFont, width: CGFloat) -> CGFloat {
        let constraintSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        
        let boundingBox = text.boundingRect(with: constraintSize,
                                            options: [.usesLineFragmentOrigin, .usesFontLeading],
                                            attributes: attributes,
                                            context: nil)
        
        return ceil(boundingBox.height)
    }
    
    @objc func buttonAction(sender: UIButton) {
        removeView()
    }
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.view)

        switch gesture.state {
        case .changed:
            self.view.transform = CGAffineTransform(translationX: 0, y: max(0, translation.y))
        case .ended, .cancelled:
            if translation.y > 250 {
                removeView()
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.view.transform = .identity
                }
            }
        default:
            break
        }
    }
    
    private func removeView() {
        UIView.animate(withDuration: 0.6, animations: {
            self.view.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        },completion: {_ in
            self.view.removeFromSuperview()
            self.dismiss(animated: true)
        })
    }
}

//MARK: UICollectionViewDelegate

extension RulesViewController: UICollectionViewDelegate {

}

//MARK: UICollectionViewDelegate

extension RulesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rulesModel.rules.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RuleCell", for: indexPath) as! RuleCell
        itemCell.configure(with: rulesModel.rules[indexPath.row], number: indexPath.row + 1, withButton: (indexPath.row == 1))
        return itemCell
    }
}

//MARK: UICollectionViewDelegateFlowLayout

extension RulesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = calculateTextHeight(text: rulesModel.rules[indexPath.row],
                                         font: UIFont.systemFont(ofSize: 18, weight: .medium),
                                         width: collectionRulesView.frame.width - 60)
        return CGSize(width: collectionRulesView.frame.width - 60 , height: indexPath.row == 1 ? height + 40 : height)
    }
}
