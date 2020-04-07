//
//  AppDelegate.swift
//  testHtml
//
//  Created by Can Lee on 2020/4/4.
//  Copyright © 2020 Can Lee. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func applicationDidFinishLaunching(_ application: UIApplication) {
        self.window = UIWindow()
        self.window?.rootViewController = ViewController()
        self.window?.makeKeyAndVisible()
    }


}

