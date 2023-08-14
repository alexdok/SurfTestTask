//
//  TableViewCell.swift
//  SurfTestTask
//
//  Created by алексей ганзицкий on 01.08.2023.
//

import UIKit

struct ProfileContainerCellModel {
    var name: String
    var description: String
}

final class ProfileContainerCell: UITableViewCell {
    let profileContainerView = UIView()
    let profileTitleLabel = UILabel()
    let profileImageView = UIImageView()
    let nameLabel = UILabel()
    let hiddenLabel = UILabel()
    let descriptionLabel = UILabel()
    let placeLabel = UILabel()
    let imagePin = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(profileContainerView)
        
        profileContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileContainerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            profileContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            profileContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            profileContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        profileContainerView.backgroundColor = .systemGray6

        // Добавление места под фото
        profileContainerView.addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileImageView.centerXAnchor.constraint(equalTo: profileContainerView.centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: profileContainerView.topAnchor, constant: 20),
            profileImageView.widthAnchor.constraint(equalToConstant: 120),
            profileImageView.heightAnchor.constraint(equalToConstant: 120),
        ])
        profileImageView.layer.cornerRadius = 60
        profileImageView.image = UIImage(named: "photo")
        profileImageView.clipsToBounds = true

        // Добавление UILabel для имени и фамилии
        nameLabel.text = ""
        nameLabel.numberOfLines = 2
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        nameLabel.lineBreakMode = .byTruncatingTail
        nameLabel.textColor = .black
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        profileContainerView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
               nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 16),
               nameLabel.leadingAnchor.constraint(equalTo: profileContainerView.leadingAnchor, constant: 10),
               nameLabel.trailingAnchor.constraint(equalTo: profileContainerView.trailingAnchor, constant: -10),
           ])

        // Добавление UILabel для описания профиля
        descriptionLabel.numberOfLines = 2
        descriptionLabel.textColor = UIColor(red: 0.588, green: 0.584, blue: 0.608, alpha: 1)
        descriptionLabel.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        descriptionLabel.text = ""
        descriptionLabel.lineBreakMode = .byTruncatingTail
        descriptionLabel.textAlignment = .center
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        profileContainerView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: profileContainerView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: profileContainerView.trailingAnchor, constant: -20),
        ])
        // Добавление UILabel для места жительства пользователя
        profileContainerView.addSubview(placeLabel)
        placeLabel.translatesAutoresizingMaskIntoConstraints = false
        placeLabel.numberOfLines = 1
        placeLabel.textAlignment = .center
        placeLabel.textColor = UIColor(red: 0.588, green: 0.584, blue: 0.608, alpha: 1)
        placeLabel.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        placeLabel.lineBreakMode = .byTruncatingTail
        placeLabel.text = "town".localized
        
        NSLayoutConstraint.activate([
            placeLabel.leadingAnchor.constraint(equalTo: profileContainerView.leadingAnchor, constant: 20),
            placeLabel.trailingAnchor.constraint(equalTo: profileContainerView.trailingAnchor, constant: -20),
            placeLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 1),
        ])
        // для маркера чтоб не уезжал
        profileContainerView.addSubview(hiddenLabel)
        hiddenLabel.translatesAutoresizingMaskIntoConstraints = false
        hiddenLabel.numberOfLines = 1
        hiddenLabel.textAlignment = .center
        hiddenLabel.textColor = .clear
        hiddenLabel.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        hiddenLabel.lineBreakMode = .byTruncatingTail
        hiddenLabel.text = "town".localized
        
        NSLayoutConstraint.activate([
            hiddenLabel.centerXAnchor.constraint(equalTo: profileContainerView.centerXAnchor),
            hiddenLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 1),
        ])
        // Добавление значка пина
        profileContainerView.addSubview(imagePin)
        imagePin.translatesAutoresizingMaskIntoConstraints = false
        imagePin.image = UIImage(named: "Pin")
        imagePin.contentMode = .scaleAspectFit
        imagePin.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            imagePin.trailingAnchor.constraint(equalTo: hiddenLabel.leadingAnchor, constant: -2),
            imagePin.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 2),
            imagePin.bottomAnchor.constraint(equalTo: hiddenLabel.bottomAnchor),
            imagePin.widthAnchor.constraint(equalToConstant: 16),
        ])
    }

    func configure(with model: ProfileContainerCellModel) {
        nameLabel.text = model.name
        descriptionLabel.text = model.description
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
