//
//  HomeWorksPicker.swift
//  home_work_11
//
//  Created by Pavel Bondar on 13.01.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit.UIPickerView
import CoreData.NSFetchRequest

class HomeWorksPicker: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    private let context = CoreDataStack.shared.persistentContainer.viewContext
    private let fetchRequest: NSFetchRequest<HomeWorks> = HomeWorks.fetchRequest()

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
        AlertMarkViewController.dismiss()
    }

    private func getData(row: Int) -> String {
        let homeWorks = try? context.fetch(fetchRequest)
        return (homeWorks?[row].task!)! + " - " + (homeWorks?[row].lecture!)!
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let homeWorks = try? context.fetch(fetchRequest)
        return homeWorks?.count ?? 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return getData(row: row)
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        AlertMarkViewController.passItem(item: getData(row: row))
    }
}
