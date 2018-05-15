//
//  ContainerViewController.swift
//  SentiaCodeTest
//
//  Created by Simeng Liu on 14/5/18.
//  Copyright © 2018 Simeng Liu. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
         performOverrideTraitCollection()
    }
    
    private func performOverrideTraitCollection() {
        for childVC in self.childViewControllers {
            setOverrideTraitCollection(UITraitCollection(horizontalSizeClass: .compact), forChildViewController: childVC)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
