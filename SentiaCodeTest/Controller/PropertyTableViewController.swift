//
//  PropertyTableViewController.swift
//  SentiaCodeTest
//
//  Created by Simeng Liu on 14/5/18.
//  Copyright © 2018 Simeng Liu. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire
import ObjectMapper
import SDWebImage

class PropertyTableViewController: UITableViewController {
    
    var data : NSMutableArray = NSMutableArray()
    var selectedId : Int?
    var collapseDetailViewController: Bool  = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataResult()
        
        self.title = "Peoperty List"
        
        self.refreshControl = UIRefreshControl()
        
        createDropdownFresh()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    // MARK: - Refresh
    func createDropdownFresh() -> Void {
        
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl?.addTarget(self, action:#selector(refresh), for: UIControlEvents.valueChanged)
        self.tableView.addSubview(self.refreshControl!)
        
    }
    
    @objc func refresh(sender:AnyObject) {
        
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
        
    }
    
     // MARK: - Networking
    func getDataResult() {
        
        SVProgressHUD.show()
        
        let url = "http://demo0065087.mockable.io/test/properties"
        
        Alamofire.request(url)
            .validate()
            .responseJSON {response in
                switch response.result {
                case .success(let value):
                    
                    let data = (value as! [String:Any])["data"] as! [Any]
                    
                    for index in stride(from: 0, to: data.count, by: 1){
                        
                        let propertyData = data[index] as! [String:Any]
                        let property = Mapper<Property>().map(JSONObject: propertyData)
                        
                        self.data.add(property as Any)
                    }
                    
                    self.tableView.reloadData()
                    
                    SVProgressHUD.dismiss()
                    
                case .failure(let error):
                    
                    print("Request Error:\(error)")
                    
                    SVProgressHUD.dismiss()
                    
                    let alert = UIAlertController(title: "Alert", message: "Request Time out, please Check your Network", preferredStyle: UIAlertControllerStyle.alert)
                    
                    self.present(alert, animated: true, completion: nil)
                    
                }//[End of switch]
        }//[End of response]
    }//[End of get data result]
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "propertyCell", for: indexPath) as! PropertyTableViewCell
        
        let property = self.data[indexPath.row] as! Property
        
        cell.titleLabel?.text = property.title
        cell.addressLabel?.text = property.location_address_2 + "," + property.location_address_1
        cell.suburbLabel.text = property.location_suburb + "," + property.location_postcode
        
        cell.bedroomNumLabel.text = String(property.bedrooms)
        cell.bathroomNumLabel.text = String(property.bathrooms)
        cell.carpartNumLabel.text = String(property.carspots)
        
        
        cell.ownerNameLabel.text = property.first_name + " " + property.last_name
       
        cell.avatarImageview.sd_setImage(with:  URL(string: property.avatar_medium!) as URL!, placeholderImage: UIImage(named:"placeholder_user"), options: .continueInBackground) { (image, erro, cacheTyoe, url) in
        }
        
        if let isFetured = property.is_premium{
            cell.isFeaturedLabel.isHidden = !isFetured
            
        }else {
            cell.isFeaturedLabel.isHidden = true
        }
        
        if let propertyUrl = property.photo {
            cell.propertyImage.sd_setImage(with:  URL(string:propertyUrl) as URL!, placeholderImage: UIImage(named:"placeholder"), options: .continueInBackground) { (image, erro, cacheTyoe, url) in}
            
        }else{
            cell.propertyImage.image = UIImage(named:"placeholder")
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        collapseDetailViewController = false
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDetail"{
            // detailViewController should never be assigned to nil !!!
            var detailViewController: DetailViewController!
            
            // with help of adaptive segue we can support all devices
            if let detailNavigationController = segue.destination as? UINavigationController {
                
                // works on devices where UISplitViewController is implemented
                detailViewController = detailNavigationController.topViewController as! DetailViewController
                detailViewController.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                detailViewController.navigationItem.leftItemsSupplementBackButton = true
            }
            // segue provides a new instance of detail view everytime
            if let selectedRowIndexPath = tableView.indexPathForSelectedRow {
                
                let property = self.data[selectedRowIndexPath.row] as! Property
                detailViewController.propertyId = property.id!
                detailViewController.propertyTitle = property.title!
                
            }
        }
    }
}



