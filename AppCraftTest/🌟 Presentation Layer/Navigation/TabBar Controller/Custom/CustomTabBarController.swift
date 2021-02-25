//
//  CustomTabBarController.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 25.02.2021.
//

import UIKit
import ESTabBarController_swift

class CustomTabBarController: ESTabBarController {
    
    // MARK: - Props
    private let firstSelected: Int
    private var firstPresent: Bool = true
    private var items: [CustomTabBarComponent] = []
    private var currentItem: CustomTabBarComponent?
    private var viewBackgroundColorDefault: UIColor = .white
    
    // MARK: - Lifecycle
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    init(firstSelected: Int) {
        self.firstSelected = firstSelected
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepare()
    }
    
    public func switchToCurrentItem() {
        guard let currentItem = self.currentItem, let index = self.items.firstIndex(where: { $0.type == currentItem.type }), (self.viewControllers ?? []).indices.contains(index) else { return }
        self.selectedIndex = index
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let newItem = self.items.first(where: { $0.tag == item.tag }) {
            self.currentItem = newItem
        }

        self.firstPresent = false
        super.tabBar(tabBar, didSelect: item)
        self.items.forEach { $0.didSelectItem($0.tag == item.tag) }
    }
    
    private func prepare() {
        self.tabBar.apply(.tabBarDefault)
        self.delegate = self
        let items = CustomTabBarComponent.createList(selectedItem: .all)
        self.items = items
        let viewControllers = items.map { $0.navigationController }
        viewControllers.forEach { $0.interactivePopGestureRecognizer?.delegate = self }
        self.viewControllers = viewControllers
        self.selectedIndex = self.firstSelected
        self.currentItem = self.items[self.firstSelected]
    }
    
    // MARK: - Route
//    private func showAllList() {
//        DispatchQueue.main.async {
//            let vc
//        }
//    }
//
//    private func showSavedList() {
//
//    }
}

// MARK: - UIGestureRecognizerDelegate
extension CustomTabBarController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let navigationController = self.selectedViewController as? UINavigationController else { return false }
        guard
            gestureRecognizer == navigationController.interactivePopGestureRecognizer,
            navigationController.viewControllers.count <= 1
        else { return true }
        return false
    }
    
}

extension CustomTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        true
    }
    
}

extension UIViewController {
    var customTabBarController: CustomTabBarController? {
        self.tabBarController as? CustomTabBarController
    }
}
