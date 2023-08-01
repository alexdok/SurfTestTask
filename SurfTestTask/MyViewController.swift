import UIKit

class MyViewController: UIViewController, SkillsTableViewCellDelegate {
    var tableView: UITableView!
    
    // Enum representing sections
    enum Section {
        case profile
        case tags
        case about
    }
    
    private let sectionCellIdentifiers: [Section: String] = [
        .profile: "ProfileContainerCell",
        .tags: "SkillsTagsTableViewCell",
        .about: "AboutMeTableViewCell",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel = UILabel()
        titleLabel.text = "Профиль"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
        navigationItem.titleView?.backgroundColor = .systemGray6
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .systemGray6
        tableView.separatorStyle = .none
        
        tableView.register(ProfileContainerCell.self, forCellReuseIdentifier: sectionCellIdentifiers[.profile]!)
        tableView.register(SkillsTagsTableViewCell.self, forCellReuseIdentifier: sectionCellIdentifiers[.tags]!)
        tableView.register(AboutMeTableViewCell.self, forCellReuseIdentifier: sectionCellIdentifiers[.about]!)
    
        view.addSubview(tableView)
    }
    
    func addNewTag(_ tag: String) {
           // метод вызова в ячейке
           if let cell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? SkillsTagsTableViewCell {
               cell.addTag(text: tag)
           }
       }
    
    func alertForNewTag() {
        createAlertController()
       }
    
    func createAlertController() {
          let alert = UIAlertController(title: "Добавление навыка", message: "Введите название навыка, которым вы владеете", preferredStyle: .alert)

          alert.addTextField { textField in
              textField.placeholder = "Введите название"
          }
          let saveAction = UIAlertAction(title: "Добавить", style: .default) { _ in
              if let nameTextField = alert.textFields?.first, let itemName = nameTextField.text {
                  self.addNewTag(itemName)
              }
          }
          let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)

          alert.addAction(saveAction)
          alert.addAction(cancelAction)

          present(alert, animated: true)
      }
}

extension MyViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        print(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 287.0
        case 1:
            return 385.0
        case 2:
            return 200
        default:
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        switch indexPath.row {
        case 0:
            if let customCell = tableView.dequeueReusableCell(withIdentifier: sectionCellIdentifiers[.profile] ?? "", for: indexPath) as? ProfileContainerCell {
                cell = customCell
            } else {
                cell = UITableViewCell()
            }
        case 1:
            if let customCell = tableView.dequeueReusableCell(withIdentifier: sectionCellIdentifiers[.tags] ?? "", for: indexPath) as? SkillsTagsTableViewCell {
                customCell.delegate = self
                cell = customCell
            } else {
                cell = UITableViewCell()
            }
        case 2:
            if let customCell = tableView.dequeueReusableCell(withIdentifier: sectionCellIdentifiers[.about] ?? "", for: indexPath) as? AboutMeTableViewCell {
                cell = customCell
            } else {
                cell = UITableViewCell()
            }
        default:
            cell = UITableViewCell()
        }
        return cell
    }
}
