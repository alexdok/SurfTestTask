import UIKit

struct AlertModel {
    var title: String
    var message: String
}

protocol AlertBuilder {
    func createAlert(with model: AlertModel, saveActionClosure: @escaping (String) -> Void) -> UIAlertController
}

final class AlertBuilderImpl: AlertBuilder {
    func createAlert(with model: AlertModel, saveActionClosure: @escaping (String) -> Void) -> UIAlertController {
        let alert = UIAlertController(title: model.title, message: model.message, preferredStyle: .alert)

        alert.addTextField { textField in
            textField.placeholder = "Введите название"
        }
        let saveAction = UIAlertAction(title: "Добавить", style: .default) { _ in
            if let nameTextField = alert.textFields?.first, let itemName = nameTextField.text {
                saveActionClosure(itemName)
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)

        alert.addAction(saveAction)
        alert.addAction(cancelAction)

        return alert
    }
}
