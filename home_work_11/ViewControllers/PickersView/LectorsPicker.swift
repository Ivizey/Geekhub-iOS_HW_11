//
//  LectorsPicker.swift
//  home_work_11
//
//  Created by Pavel Bondar on 11.01.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit.UIPickerView
import CoreData.NSFetchRequest

class LectorsPicker: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    private let context = CoreDataStack.shared.persistentContainer.viewContext
    private let fetchRequest: NSFetchRequest<Lectors> = Lectors.fetchRequest()

    func showToolBar() -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.isUserInteractionEnabled = true
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .done,
                                         target: self,
                                         action: #selector(dismissPicker))
        toolBar.setItems([doneButton], animated: false)
        return toolBar
    }

    @objc private func dismissPicker() {
        AlertViewController.dismiss()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let lectors = try? context.fetch(fetchRequest)
        return lectors?.count ?? 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let lectors = try? context.fetch(fetchRequest)
        return (lectors?[row].name!)! + " " + (lectors?[row].surname!)!
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let lectors = try? context.fetch(fetchRequest)
        AlertViewController.passItem(item: (lectors?[row].name!)! + " " + (lectors?[row].surname!)!)
    }
}
