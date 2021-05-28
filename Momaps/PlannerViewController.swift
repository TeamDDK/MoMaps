//
//  PlannerViewController.swift
//  Momaps
//
//  Created by Cosmo on 4/26/21.
//

import UIKit
import Parse
import NotificationBannerSwift

extension UITableView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .lightGray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 30)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}

protocol PlannedViewControllerDelegate {
    func didSelectPlanned(_lat: Double, _long: Double, _name: String, _description: String)
    func didDeletePlanned(_lat: Double, _long: Double, _name: String, _description: String)
}

class PlannerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var plannedDelegate: PlannedViewControllerDelegate?
    
    
    var locations = [PFObject]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let query = PFQuery(className: "PlanLocations")
        query.includeKey("user")
        query.limit = 20
        
        query.findObjectsInBackground { locations, error in
            if locations != nil{
                self.locations = locations!
                self.tableView.reloadData()
                //print(locations)
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if locations.count == 0 {
                self.tableView.setEmptyMessage("Add new places you want to visit through the add new screen!")
            } else {
                self.tableView.restore()
            }

            return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlannerTableViewCell") as! PlannerTableViewCell
        
        let location = locations[indexPath.row]
        
        cell.nameLabel.text = location["Name"] as! String
        cell.addressLabel.text = location["Address"] as! String
        cell.descriptionLabel.text = location["Description"] as! String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = locations[indexPath.row]
        let name = location["Name"] as! String
        let description = location["Description"] as! String
        let latitude = location["Latitude"] as! Double
        let longitude = location["Longitude"] as! Double
        
        plannedDelegate?.didSelectPlanned(_lat: latitude, _long: longitude, _name: name, _description: description)
        

    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let location = locations[indexPath.row]
            let name = location["Name"] as! String
            let description = location["Description"] as! String
            let latitude = location["Latitude"] as! Double
            let longitude = location["Longitude"] as! Double
            
            let object = locations[indexPath.row] as! PFObject
            self.locations.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            //print(object)
            object.deleteInBackground { (success, error) in
                        if (success) {
                            self.plannedDelegate?.didDeletePlanned(_lat: latitude, _long: longitude, _name: name, _description: description)
                            self.tableView.reloadData()
                        } else {
                            let error = error?.localizedDescription as! String
                            let banner = GrowingNotificationBanner(title: "Whoops we had a problem with the deletion", subtitle: "\(error)", leftView: nil, rightView: nil, style: .danger, colors: nil)
                        }
                    }
        }
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
