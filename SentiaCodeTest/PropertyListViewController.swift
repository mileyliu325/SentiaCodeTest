//
//  PropertyListViewController.swift
//  SentiaCodeTest
//
//  Created by Simeng Liu on 14/5/18.
//  Copyright © 2018 Simeng Liu. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire
import ObjectMapper

class PropertyListViewController: UISplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataResult()

        // Do any additional setup after loading the view.
    }
    
    func getDataResult() {
        
        SVProgressHUD.show()
        
        let url = "http://demo0065087.mockable.io/test/properties"
        
        Alamofire.request(url)
            .validate()
            .responseJSON {response in
                switch response.result {
                case .success(let value):
                    
                     let data = (value as! [String:Any])["data"] as! [Any]
                      
                    
//                    let daily = (value as! [String:Any]) ["daily"] as! [String:Any]
//                    let data = daily ["data"] as! [Any]
//
                    for index in stride(from: 0, to: data.count, by: 1){

                        let propertyData = data[index] as! [String:Any]
                        let property = Mapper<Property>().map(JSONObject: propertyData)
                        
                        print(property?.title)

//                        self.data.add(weatherData as Any)
                    }
//                    self.weatherTableView.reloadData()
                    
                    SVProgressHUD.dismiss()
                    
                case .failure(let error):
                    
                    print("Request Error:\(error)")
                    
                    SVProgressHUD.dismiss()
                    
                    let alert = UIAlertController(title: "Alert", message: "Request Time out, please Check your Network", preferredStyle: UIAlertControllerStyle.alert)
                    
                    self.present(alert, animated: true, completion: nil)
                    
                }
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
