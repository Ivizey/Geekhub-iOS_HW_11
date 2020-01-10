//
//  PickerView.swift
//  home_work_11
//
//  Created by Pavel Bondar on 10.01.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit
import CoreData

class PickerView: UIViewController {
    private let context = CoreDataStack.shared.persistentContainer.viewContext

    private let toolBar: UIToolbar = {
        let toolBar = UIToolbar()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: nil)
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        toolBar.setItems([doneButton], animated: true)
        return toolBar
    }()

//    private let picker: UIPickerView = {
//        let picker = UIPickerView()
//        picker.backgroundColor = .white
//        return picker
//    }()

    private let fetchRequest: NSFetchRequest<Lectors> = {
        var fetchRequest: NSFetchRequest<Lectors> = Lectors.fetchRequest()
        return fetchRequest
    }()

    func createPicker() -> UIPickerView {
        let picker = UIPickerView()
        picker.backgroundColor = .white
        picker.delegate = self
        return picker
    }
}

// MARK: - UIPickerViewDataSource, UIPickerViewDelegate
extension PickerView: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let lectors = try? context.fetch(fetchRequest)
        return lectors?.count ?? 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let lectors = try? context.fetch(fetchRequest)
        return lectors?[row].name
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        let lectors = try? context.fetch(fetchRequest)
//        alertDialog.textFields![1].text = lectors?[row].name
    }
}
