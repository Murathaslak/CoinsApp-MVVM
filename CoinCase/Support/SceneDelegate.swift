//
//  SceneDelegate.swift
//  CoinCase
//
//  Created by Osman Murat Haslak on 7.10.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = UINavigationController(rootViewController: HomeScreen())
        window?.makeKeyAndVisible()
    }
    
    func createTabbar() -> UITabBarController {
           let tabbar = UITabBarController()
           UITabBar.appearance().tintColor = .systemGreen
           tabbar.viewControllers = [createSearchNC(), createFavoritesNC()]
           
           return tabbar
       }
    
    func createSearchNC() -> UINavigationController {
        let homeVC = HomeScreen()
        homeVC.tabBarItem = UITabBarItem(title: "Anasayfa", image: UIImage(systemName: "house.circle"), selectedImage: UIImage(systemName: "house.circle.fill"))
        return UINavigationController(rootViewController: homeVC)
    }
    
    func createFavoritesNC() -> UINavigationController {
        let favoritesListVC = MyCoinsListScreen()
        favoritesListVC.title = "Cüzdan"
        favoritesListVC.tabBarItem = UITabBarItem(title: "Cüzdan", image: UIImage(systemName: "bitcoinsign.circle"), selectedImage: UIImage(systemName: "bitcoinsign.circle.fill"))
        return UINavigationController(rootViewController: favoritesListVC)
    }
    
}

