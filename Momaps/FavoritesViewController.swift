//
//  FavoritesViewController.swift
//  Momaps
//
//  Created by Cosmo on 4/26/21.
//

import UIKit
import Parse
import NotificationBannerSwift

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //location["latitude"]
    //locaton["longitude"]
    
    @IBOutlet weak var tableView: UITableView!
    
    var locations = [PFObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let query = PFQuery(className: "FaveLocations")
        query.includeKey("user")
        query.limit = 20
        
        query.findObjectsInBackground { locations, error in
            if locations != nil{
                self.locations = locations!
                self.tableView.reloadData()
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if locations.count == 0 {
                self.tableView.setEmptyMessage("Add your favorite locations through the add new screen!")
            } else {
                self.tableView.restore()
            }

            return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesTableViewCell") as! FavoritesTableViewCell
        
        let location = locations[indexPath.row]
        
        cell.nameLabel.text = location["Name"] as! String
        cell.addressLabel.text = location["Address"] as! String
        cell.descriptionLabel.text = location["Description"] as! String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let object = locations[indexPath.row] as! PFObject
            self.locations.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            print(object)
            object.deleteInBackground { (success, error) in
                        if (success) {
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
