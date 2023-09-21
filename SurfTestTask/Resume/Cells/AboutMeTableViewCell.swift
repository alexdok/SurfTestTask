//
//  AboutMeTableViewCell.swift
//  SurfTestTask
//
//  Created by алексей ганзицкий on 01.08.2023.
//

import UIKit

final class AboutMeTableViewCell: UITableViewCell {
    
    let aboutMeLabel = UILabel()
    let textAboutMeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupAboutMeLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAboutMeLabel() {
        aboutMeLabel.text = "about".localized
        aboutMeLabel.font = UIFont(name: Fonts.sFProDisplayMedium.name, size: 16)
        contentView.addSubview(aboutMeLabel)
         aboutMeLabel.translatesAutoresizingMaskIntoConstraints = false
         
         NSLayoutConstraint.activate([
             aboutMeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
             aboutMeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
             aboutMeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
         ])

         contentView.addSubview(textAboutMeLabel)
        textAboutMeLabel.font = UIFont(name: Fonts.sFProDisplayMedium.name, size: 14)
         textAboutMeLabel.numberOfLines = 100
         textAboutMeLabel.translatesAutoresizingMaskIntoConstraints = false
        textAboutMeLabel.text = "about me".localized
         
         NSLayoutConstraint.activate([
             textAboutMeLabel.topAnchor.constraint(equalTo: aboutMeLabel.bottomAnchor, constant: 8),
             textAboutMeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
             textAboutMeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
         ])
     }
}
