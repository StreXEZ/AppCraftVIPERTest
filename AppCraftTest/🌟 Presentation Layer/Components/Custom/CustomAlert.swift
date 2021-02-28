//
//  CustomAlert.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 01.03.2021.
//

import UIKit

class CustomAlerts {
    static func deleteAlert(callback: @escaping () -> Void) -> UIAlertController {
        let alertController = UIAlertController(title: "Вы уверены?", message: "Если вы удалите покемона, то его данные сотрутся с вашего устройства", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { action in
            callback()
        }
        let dismissAction = UIAlertAction(title: "Отмена", style: .cancel)
        alertController.addAction(deleteAction)
        alertController.addAction(dismissAction)
        return alertController
    }
}
