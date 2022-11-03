//
//  MainViewController.swift
//  ELTest
//
//  Created by Omar Gonzalez on 28/10/22.
//

import UIKit

// MARK: MainViewController
final class MainViewController: UITabBarController {
    // MARK: - Properties
    let favoritesViewController: UIViewController
    let searchViewController: UIViewController

    // MARK: - Initializers
    init(favoritesViewController: UIViewController, searchViewController: UIViewController) {
        self.favoritesViewController = favoritesViewController
        self.searchViewController = searchViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle methods
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

    // MARK: viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if #available(iOS 15.0, *) {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            tabBar.scrollEdgeAppearance = tabBarAppearance
        }
    }
    
    // MARK: - Private methods
    // MARK: SetupTabBar
    private func setupTabBar() {
        let item1 = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        let item2 = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)

        searchViewController.tabBarItem = item1
        favoritesViewController.tabBarItem = item2
        tabBar.unselectedItemTintColor = .systemGray3
        
        self.viewControllers = [searchViewController, favoritesViewController]
    }
}
