//
//  PlannerViewController.swift
//  Momaps
//
//  Created by Cosmo on 4/26/21.
//

import UIKit
import Parse

class PlannerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var locations = [PFObject]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let query = PFQuery(className: "PlanLocations")
        query.includeKey("User")
        query.limit = 20
        
        query.findObjectsInBackground { locations, error in
            if locations != nil{
                self.locations = locations!
                self.tableView.reloadData()
                print(locations)
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            self.locations.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            
            let location = locations[indexPath.row]
            let id = location["objectId"] as! String
            let query = PFQuery(className: "PlanLocations")
            query.getObjectInBackground(withId: "asdfasdf") { (object,error) -> Void in
                if object != nil && error == nil{
                    object!.deleteInBackground()
                    print("Object just deleted!")
                }else{
                    print("error")
                }
            }
        
        /*
            objectToDelete.deleteInBackground { (success, error) in
                        if (success) {
                            print("It worked")
                            // Force a reload of the table - fetching fresh data from Parse platform
                            //self.loadObjects()
                        } else {
                            // There was a problem, check error.description
                        }


        }
            */
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
