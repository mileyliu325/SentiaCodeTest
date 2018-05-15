//
//  DetailViewController.swift
//  SentiaCodeTest
//
//  Created by Simeng Liu on 14/5/18.
//  Copyright © 2018 Simeng Liu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var propertyIdLabel: UILabel!
    var propertyId: Int?
    var propertyTitle: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title  = "Property Detail"
        
        if let propertyT = propertyTitle {
            self.propertyIdLabel.text = "Title :\(propertyT)"
            
        }
        else{
            self.propertyIdLabel.text = "No property Selected"
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
