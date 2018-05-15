//
//  SplitExtension.swift
//  SentiaCodeTest
//
//  Created by Simeng Liu on 15/5/18.
//  Copyright © 2018 Simeng Liu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - iPad ios7support

extension UISplitViewController: UISplitViewControllerDelegate {
    
    struct ios7Support {
        static var modeButtonItem: UIBarButtonItem?
    }
    
    var backBarButtonItem: UIBarButtonItem? {
        get {
            if responds(to: #selector(getter: UISplitViewController.displayModeButtonItem)) == true {
                let button: UIBarButtonItem = displayModeButtonItem
                return button
            } else {
                return ios7Support.modeButtonItem
            }
        }
        set {
            ios7Support.modeButtonItem = newValue
        }
    }
    
    // simple trick, without swizzling :-)
    
    func displayModeButtonItem(_: Bool = true)->UIBarButtonItem? {
        return backBarButtonItem
    }
    
    public func splitViewController(_ svc: UISplitViewController, willHide aViewController: UIViewController, with barButtonItem: UIBarButtonItem, for pc: UIPopoverController) {
        if (!svc.responds(to: #selector(getter: UISplitViewController.displayModeButtonItem))) {
            if let detailView = svc.viewControllers[svc.viewControllers.count-1] as? UINavigationController {
                print("willHide")
                svc.backBarButtonItem = barButtonItem
                detailView.topViewController?.navigationItem.leftBarButtonItem = barButtonItem
            }
        }
    }
    
    
    public func splitViewController(_ svc: UISplitViewController, willShow aViewController: UIViewController, invalidating barButtonItem: UIBarButtonItem) {
        if (!svc.responds(to: #selector(getter: UISplitViewController.displayModeButtonItem))) {
            if let detailView = svc.viewControllers[svc.viewControllers.count-1] as? UINavigationController {
                  print("willShow")
                svc.backBarButtonItem = nil
                detailView.topViewController?.navigationItem.leftBarButtonItem = nil
               
            }
        }
    }
    
    // MARK: - user defined imlementation of UISplitViewControllerDelegate
    
    public func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if let navController = primaryViewController as? UINavigationController {
            if let controller = navController.topViewController as? PropertyTableViewController {
                return controller.collapseDetailViewController
            }
        }
        return true
    }

    
}



