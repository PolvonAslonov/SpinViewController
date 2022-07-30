//
//  AppDelegate.swift
//  SpinViewController
//
//  Created by user on 23/07/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window?.rootViewController = UINavigationController(rootViewController: Spin2ViewController())
        return true
        
        
    }


    }




