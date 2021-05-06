//
//  AddViewController.swift
//  Momaps
//
//  Created by Cosmo on 4/26/21.
//

import UIKit
import Parse

class AddViewController: UIViewController {

    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var descriptionlabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!

    
    @IBAction func addFavoritesButton(_ sender: Any) {
        let FaveLocations = PFObject(className: "FaveLocations")
        FaveLocations["Name"] = nameTextField.text!
        FaveLocations["Address"] = addressTextField.text!
        FaveLocations["Description"] = descriptionTextField.text!
        FaveLocations["User"] = PFUser.current()
        
        FaveLocations.saveInBackground { success, error in
            if success{
                print("YAAY")
            }else{
                print("Error nigga")
            }
        }
    }
    @IBAction func addPlansButton(_ sender: Any) {
        let PlanLocations = PFObject(className: "PlanLocations")
        PlanLocations["Name"] = nameTextField.text!
        PlanLocations["Address"] = addressTextField.text!
        PlanLocations["Description"] = descriptionTextField.text!
        PlanLocations["User"] = PFUser.current()
        
        PlanLocations.saveInBackground { success, error in
            if success{
                print("YAAY")
            }else{
                print("Error nigga")
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.layer.cornerRadius = 10.0
        nameTextField.layer.borderWidth = 2.0
        nameTextField.layer.borderColor = UIColor.black.cgColor
        nameTextField.layer.masksToBounds = true
        
        addressTextField.layer.cornerRadius = 10.0
        addressTextField.layer.borderWidth = 2.0
        addressTextField.layer.borderColor = UIColor.black.cgColor
        addressTextField.layer.masksToBounds = true
        
        descriptionTextField.layer.cornerRadius = 10.0
        descriptionTextField.layer.borderWidth = 2.0
        descriptionTextField.layer.borderColor = UIColor.black.cgColor
        descriptionTextField.layer.masksToBounds = true
        descriptionTextField.textAlignment = .left
        descriptionTextField.contentVerticalAlignment = .top

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
