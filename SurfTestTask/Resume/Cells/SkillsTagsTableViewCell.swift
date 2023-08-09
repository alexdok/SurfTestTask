//
//  SkillsTableViewCell.swift
//  SurfTestTask
//
//  Created by алексей ганзицкий on 01.08.2023.

import UIKit
protocol SkillsTableViewCellDelegate: AnyObject {
    func alertForNewTag()
}

protocol SkillsTableViewCellChangeHeightDelegate: AnyObject {
    func addHeight()
    func removeHeight()
}

class SkillsTagsTableViewCell: UITableViewCell {
    weak var delegate: SkillsTableViewCellDelegate?
    weak var delegateHeight: SkillsTableViewCellChangeHeightDelegate?
    let skillsContainerView = UIView()
    let skillsLabel = UILabel()
    var isEditingMode: Bool = false
    let editButton = UIButton()
    var lastPositionY: CGFloat = 0
    var arrayPositionsY: [CGFloat] = []
    
    var txtInput = ""
    var tagsArray: [String] = []

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

    }

    func configure(with tags: [String]) {
        tagsArray = tags
        addSkillsContainer()
    }
    
    func addSkillsContainer() {
        contentView.addSubview(skillsContainerView)
        skillsContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            skillsContainerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            skillsContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            skillsContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            skillsContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        skillsContainerView.backgroundColor = .white
        // Настройка UILabel "Мои навыки"
        skillsLabel.text = "Мои навыки"
        skillsLabel.font = UIFont(name: "SFProDisplay-Bold", size: 20)
        skillsLabel.textColor = .black
        skillsLabel.translatesAutoresizingMaskIntoConstraints = false
        skillsContainerView.addSubview(skillsLabel)
        
   
        NSLayoutConstraint.activate([
            skillsLabel.topAnchor.constraint(equalTo: skillsContainerView.topAnchor, constant: 20),
            skillsLabel.leadingAnchor.constraint(equalTo: skillsContainerView.leadingAnchor, constant: 16),
        ])
        
        // Настройка кнопки "режима редактирования"
        editButton.setImage(UIImage(named: "Pan"), for: .normal) // Используйте свои собственные изображения для иконок
        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        skillsContainerView.addSubview(editButton)
        
        // Активация констрейнтов для кнопки "режима редактирования"
        NSLayoutConstraint.activate([
            editButton.centerYAnchor.constraint(equalTo: skillsLabel.centerYAnchor),
            editButton.trailingAnchor.constraint(equalTo: skillsContainerView.trailingAnchor, constant: -16),
            editButton.widthAnchor.constraint(equalToConstant: 30),
            editButton.heightAnchor.constraint(equalToConstant: 30),
        ])
        loadTags()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.createTagCloud(OnView: self.contentView, withArray: self.tagsArray as [AnyObject])
            UIButton.appearance().isHidden = true
        }
    }
    
    @objc func editButtonTapped() {
        isEditingMode.toggle()
        UIButton.appearance().isHidden = false
        if isEditingMode {
            editButton.setImage(UIImage(named: "OkButton"), for: .normal)
            addTag(text: "+")
           
        } else {
            editButton.setImage(UIImage(named: "Pan"), for: .normal)
            if !tagsArray.isEmpty {
                tagsArray.removeAll { $0 == "+" }
            }
            UIButton.appearance().isHidden = true
            createTagCloud(OnView: self.contentView, withArray: tagsArray as [AnyObject])
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.saveTags()
            }
        }
    }
    
  @IBAction func alert() {
        delegate?.alertForNewTag()
    }
    
    func saveTags() {
        UserDefaults.standard.setValue(tagsArray, forKey: "tags")
    }
    func loadTags() {
        if let tagsArray = UserDefaults.standard.value(forKey: "tags") as? [String] {
            self.tagsArray = tagsArray
        }
    }

    func addTag(text: String) {
        if text.count != 0 {
            tagsArray.append(text)
            if tagsArray.count >= 2 && tagsArray.contains("+") && tagsArray.last != "+" {
            tagsArray.swapAt(tagsArray.count - 1, tagsArray.count - 2)
            }
            createTagCloud(OnView: self.contentView, withArray: tagsArray as [AnyObject])
            saveTags()
        }
    }
    
    func createTagCloud(OnView view: UIView, withArray data:[AnyObject]) {
        for tempView in view.subviews {
            if tempView.tag != 0 {
                tempView.removeFromSuperview()
            }
        }
        
        var xPos:CGFloat = 16.0
        var yPos: CGFloat = 90
        var tag: Int = 1
        for str in data  {
            let startstring = str as! String
            let width = startstring.widthOfString(usingFont: UIFont(name:"AppleSDGothicNeo-Regular", size: 13.0)!)
            let checkWholeWidth = CGFloat(xPos) + CGFloat(width) + CGFloat(13.0) + CGFloat(25.5)
            
            if checkWholeWidth > UIScreen.main.bounds.size.width - 30.0 {
                xPos = 16
                yPos = yPos + 56
                if yPos > contentView.bounds.size.height - 50 {
                    delegateHeight?.addHeight()
                    return
                }
            }
            
            let bgView = UIView(frame: CGRect(x: xPos, y: yPos, width:width + 48 , height: 44))
            bgView.layer.cornerRadius = 14.5
            bgView.backgroundColor = .systemGray
            bgView.tag = tag
            
            if startstring == "+" {
                let recognizer = UITapGestureRecognizer(target: self, action: #selector(alert))
                bgView.addGestureRecognizer(recognizer)
            }
            
            let textlable = UILabel(frame: CGRect(x: 17.0, y: 0.0, width: width, height: bgView.frame.size.height))
            textlable.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 13.0)
            textlable.text = startstring
            textlable.textColor = UIColor.white
            bgView.addSubview(textlable)
                
            let button = UIButton(type: .custom)
            button.frame = CGRect(x: bgView.frame.size.width - 2.5 - 23.0, y: bgView.frame.size.height/2-11 , width: 22.0, height: 22.0)
            button.backgroundColor = .clear
            button.layer.cornerRadius = CGFloat(button.frame.size.width)/CGFloat(2.0)
            button.setImage(UIImage(named: "X"), for: .normal)
            button.tag = tag
            button.addTarget(self, action: #selector(removeTag(_:)), for: .touchUpInside)
            if startstring != "+" {
                bgView.addSubview(button)
            }
            xPos = CGFloat(xPos) + CGFloat(width) + CGFloat(17.0) + CGFloat(43.0)
            view.addSubview(bgView)
            tag = tag + 1
        }
    }
    
    @IBAction func removeTag(_ sender: AnyObject) {
        tagsArray.remove(at: (sender.tag - 1))
        
        createTagCloud(OnView: self.contentView, withArray: tagsArray as [AnyObject])
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.saveTags()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension String {
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
        var localized: String {
            NSLocalizedString(self, comment: "")
        }
}
