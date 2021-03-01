//
//  CustomAlert.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 01.03.2021.
//

import UIKit

class CustomAlerts {
    static func deleteAlert(callback: @escaping () -> Void) -> UIAlertController {
        let alertController = UIAlertController(title: AppLocalization.Alerts.deleteAlertTitle.localized, message: AppLocalization.Alerts.deleteAlertBody.localized, preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: AppLocalization.General.delete.localized, style: .destructive) { action in
            callback()
        }
        let dismissAction = UIAlertAction(title: AppLocalization.General.cancel.localized, style: .cancel)
        alertController.addAction(deleteAction)
        alertController.addAction(dismissAction)
        return alertController
    }
}
