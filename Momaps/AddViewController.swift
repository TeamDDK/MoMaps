//
//  AddViewController.swift
//  Momaps
//
//  Created by Cosmo on 4/26/21.
//

import UIKit
import Parse
import BLTNBoard

class AddViewController: UIViewController {
    
    private lazy var FaveboardManager: BLTNItemManager = {
        let item = BLTNPageItem(title: "Added to Favorites Tab!")
        item.image = UIImage(named: "checked")
        item.actionButtonTitle = "Continue"
        item.descriptionText = "Added location to your favorites tab!"
        item.actionHandler = { _ in
            self.didTapFaveBoardContinue()
        }
        //item.appearance.actionButtonColor = .systemGreen
        item.appearance.titleTextColor = .black
        return BLTNItemManager(rootItem: item)
    }()
    private lazy var PlanboardManager: BLTNItemManager = {
        let item = BLTNPageItem(title: "Added to Planner Tab!")
        item.image = UIImage(named: "checked")
        item.actionButtonTitle = "Continue"
        item.descriptionText = "Added location to your Planner tab!"
        item.actionHandler = { _ in
            self.didTapFaveBoardContinue()
        }
        //item.appearance.actionButtonColor = .systemGreen
        item.appearance.titleTextColor = .black
        return BLTNItemManager(rootItem: item)
    }()
    
    
    @IBOutlet weak var viewInputs: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var descriptionlabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBAction func addFavoritesButton(_ sender: Any) {
        if (nameTextField.text == "" || nameTextField.text == "" || nameTextField.text == "" ){
            let alert = UIAlertController(title: "Whoops!", message: "Please make sure all textFields are filled in!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
            
        }else{
        let FaveLocations = PFObject(className: "FaveLocations")
        FaveLocations["Name"] = nameTextField.text!
        FaveLocations["Address"] = addressTextField.text!
        FaveLocations["Description"] = descriptionTextField.text!
        FaveLocations["User"] = PFUser.current()
        
        FaveLocations.saveInBackground { success, error in
            if success{
                self.FaveboardManager.showBulletin(above: self)
            }else{
                print("Error")
            }
        }
            nameTextField.text?.removeAll()
            addressTextField.text?.removeAll()
            descriptionTextField.text?.removeAll()
    }
}
    @IBAction func addPlansButton(_ sender: Any) {
        if (nameTextField.text == "" || nameTextField.text == "" || nameTextField.text == "" ){
            let alert = UIAlertController(title: "Whoops!", message: "Please make sure all textFields are filled in!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
            
        }else{
        let PlanLocations = PFObject(className: "PlanLocations")
        PlanLocations["Name"] = nameTextField.text!
        PlanLocations["Address"] = addressTextField.text!
        PlanLocations["Description"] = descriptionTextField.text!
        PlanLocations["User"] = PFUser.current()
        
        PlanLocations.saveInBackground { success, error in
            if success{
                self.PlanboardManager.showBulletin(above: self)

            }else{
            }
        }
            nameTextField.text?.removeAll()
            addressTextField.text?.removeAll()
            descriptionTextField.text?.removeAll()
    }
}
    override func viewDidLoad() {
        super.viewDidLoad()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = viewInputs.bounds
        gradientLayer.colors = [UIColor.systemPink.cgColor,UIColor.systemOrange.cgColor]
        //viewInputs.layer.addSublayer(gradientLayer)
        nameTextField.layer.cornerRadius = 10.0
        nameTextField.layer.borderWidth = 2.0
        nameTextField.layer.borderColor = UIColor.white.cgColor
        nameTextField.layer.masksToBounds = true
        
        addressTextField.layer.cornerRadius = 10.0
        addressTextField.layer.borderWidth = 2.0
        addressTextField.layer.borderColor = UIColor.white.cgColor
        addressTextField.layer.masksToBounds = true
        
        descriptionTextField.layer.cornerRadius = 10.0
        descriptionTextField.layer.borderWidth = 2.0
        descriptionTextField.layer.borderColor = UIColor.white.cgColor
        descriptionTextField.layer.masksToBounds = true
        descriptionTextField.textAlignment = .left
        descriptionTextField.contentVerticalAlignment = .top
        viewInputs.layer.cornerRadius = 25
        viewInputs.layer.shadowColor = UIColor.black.cgColor
        viewInputs.layer.shadowOpacity = 1
        viewInputs.layer.shadowOffset = .zero
        viewInputs.layer.shadowRadius = 10
        
    }
    func didTapFaveBoardContinue(){
        self.dismiss(animated: true, completion: nil)
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
