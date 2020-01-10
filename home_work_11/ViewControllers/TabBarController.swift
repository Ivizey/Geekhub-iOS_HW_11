//
//  ViewController.swift
//  home_work_11
//
//  Created by Pavel Bondar on 03.01.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit.UITabBarController

class TabBarController: UITabBarController {
    private let nameView = [ "Lecture", "Lector", "Student", "Home work"]
    private let imageView = ["doc", "person", "person.2", "book"]

    override func viewDidLoad() {
        super.viewDidLoad()
        showTabs()
        setupView()
    }

    private func showTabs() {
        viewControllers = [createTab(LectureViewController(), 0),
                           createTab(LectorViewController(), 1),
                           createTab(StudentViewController(), 2),
                           createTab(HomeWorkViewController(), 3)
        ]
    }

    private func setupView() {
        let buttonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddAlert))
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItem = buttonItem
        self.title = tabBar.selectedItem?.title
        view.backgroundColor = .white
    }

    private func createTab(_ view: UIViewController, _ tag: Int) -> UIViewController {
        let viewController = view
        let image = UIImage(systemName: imageView[tag])
        viewController.tabBarItem = UITabBarItem(title: nameView[tag], image: image, tag: tag)
        return viewController
    }

    @objc private func handleAddAlert() {
        Alert.showBasicAlert(viewController: self, view: tabBar.selectedItem?.title ?? "")
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.title = tabBar.selectedItem?.title
    }
}
