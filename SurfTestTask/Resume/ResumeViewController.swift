import UIKit

final class ResumeViewController: UIViewController {
    enum Constants {
        static let profileCellHeight: CGFloat = 287
        static var tagsCellHeight: CGFloat = 150
        static let aboutCellHeight: CGFloat = 200
        static let changeHeigth: CGFloat = 60
    }
    private var tableView: UITableView!
    private let alertBuilder: AlertBuilder
    private let dataProvider: DataProvider
   
    
    // Enum representing sections
    private enum Section: Int, CaseIterable {
        case profile
        case tags
        case about

        var height: CGFloat {
            switch self {
            case .profile: return Constants.profileCellHeight
            case .tags: return Constants.tagsCellHeight
            case .about: return Constants.aboutCellHeight
            }
        }
    }

    init(alertBuilder: AlertBuilder, dataProvider: DataProvider) {
        self.alertBuilder = alertBuilder
        self.dataProvider = dataProvider
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItemTitle()
        tableView = createTableView()
        view.addSubview(tableView)
    }
    
    private func addNewTag(_ tag: String) {
        // метод вызова в ячейке
        if let cell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? SkillsTagsTableViewCell {
            cell.addTag(text: tag)
        }
    }
    
    private func createAlertController() {
        let alertModel = AlertModel(title: "Добавление навыка", message: "Введите название навыка, которым вы владеете")
        let alert = alertBuilder.createAlert(with: alertModel) { string in
            self.addNewTag(string)
        }
        present(alert, animated: true)
    }

    private func configureNavigationItemTitle() {
        let titleLabel = UILabel()
        titleLabel.text = "Профиль"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
        navigationItem.titleView?.backgroundColor = .systemGray6
    }
    
    
    
    func changeHeight(addOrRemoveHeight: ChanngeHeightCell) {
        switch addOrRemoveHeight {
        case .add:
            Constants.tagsCellHeight += Constants.changeHeigth
            tableView.reloadData()
        case .remove:
            guard Constants.tagsCellHeight >= 200 else { return }
            Constants.tagsCellHeight -= Constants.changeHeigth
            tableView.reloadData()
        }
    }
    
    private func createTableView() -> UITableView {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .systemGray6
        tableView.separatorStyle = .none
        tableView.allowsSelection = false

        tableView.register(ProfileContainerCell.self)
        tableView.register(SkillsTagsTableViewCell.self)
        tableView.register(AboutMeTableViewCell.self)
        return tableView
    }
}

extension ResumeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Section(rawValue: indexPath.row)?.height ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.row) else {
            return UITableViewCell()
        }
        
        switch section {
        case .profile:
            let cell = tableView.dequeueReusableCell(for: indexPath) as ProfileContainerCell
            cell.configure(with: dataProvider.modelForProfileCell())
            return cell
        case .tags:
            let cell = tableView.dequeueReusableCell(for: indexPath) as SkillsTagsTableViewCell
            cell.configure(with: dataProvider.provideCurrentTags())
            cell.delegate = self
            cell.delegateHeight = self
            return cell
        case .about:
            return tableView.dequeueReusableCell(for: indexPath) as AboutMeTableViewCell
        }
    }
}


extension ResumeViewController: SkillsTableViewCellDelegate {
    func alertForNewTag() {
        createAlertController()
    }
}

extension ResumeViewController: SkillsTableViewCellChangeHeightDelegate {
    func addHeight() {
        changeHeight(addOrRemoveHeight: .add)
    }
    
    func removeHeight() {
        changeHeight(addOrRemoveHeight: .remove)
    }
}
