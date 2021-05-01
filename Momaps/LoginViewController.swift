//
//  LoginViewController.swift
//  Momaps
//
//  Created by Cosmo on 4/26/21.
//

import UIKit
import Parse
import NotificationBannerSwift
import Lottie


class LoginViewController: UIViewController {
    
    @IBOutlet weak var animView: AnimView!
    
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginButton(_ sender: Any) {
        let username = userTextField.text!
        let password = passwordTextField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }else{
                let error = error?.localizedDescription as! String
                let banner = GrowingNotificationBanner(title: "Please try again!", subtitle: "\(error)", leftView: nil, rightView: nil, style: .danger, colors: nil)
                
                banner.show(queuePosition: .front, bannerPosition: .bottom, queue: .default, on: self)
            }
        }
    }
    
    
    
    @IBAction func signupButton(_ sender: Any) {
        let user = PFUser()
        user.username = userTextField.text!
        user.password = passwordTextField.text!
        
        user.signUpInBackground { (success, error) in
            if(success){
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }else{
                let error = error?.localizedDescription as! String
                let banner = GrowingNotificationBanner(title: "Please try again!", subtitle: "\(error)", leftView: nil, rightView: nil, style: .danger, colors: nil)
                
                banner.show(queuePosition: .front, bannerPosition: .bottom, queue: .default, on: self)
            }
    }
}
    
    override func viewDidLoad() {
        
        self.HideKeyboard()
        animView.layer.cornerRadius = 25
        animView.layer.shadowColor = UIColor.black.cgColor
        animView.layer.shadowOpacity = 1
        animView.layer.shadowOffset = .zero
        animView.layer.shadowRadius = 10
        //animView.backgroundColor = UIColor(red: 0, green: 139.0, blue: 139.0, alpha: 4)

        logo()
        //carWithFam()
        //gradientBackground()
        super.viewDidLoad()
        userTextField.layer.cornerRadius = 10.0
        userTextField.layer.borderWidth = 2.0
        userTextField.layer.borderColor = UIColor.black.cgColor
        userTextField.layer.masksToBounds = true
        passwordTextField.layer.cornerRadius = 10.0
        passwordTextField.layer.borderWidth = 2.0
        passwordTextField.layer.borderColor = UIColor.black.cgColor
        passwordTextField.layer.masksToBounds = true

        // Do any additional setup after loading the view.
    }
    
    /* was experimenting lulz
    func carWithFam(){
        let animationview = AnimationView(name: "46541-nature-visite-travel")
        animationview.frame = CGRect(x: 0, y: 100, width: 428, height: 450)
        //animationview.center = self.view.center
        animationview.contentMode = .scaleAspectFill
        view.addSubview(animationview)
        animationview.play()
        animationview.loopMode = .loop
    }
    func gradientBackground(){
        let animationview = AnimationView(name: "4159-menu-page-transition")
        animationview.frame = CGRect(x: 0, y: 500, width: 428, height: 450)
        //animationview.center = self.view.center
        animationview.contentMode = .scaleAspectFill
        view.addSubview(animationview)
        animationview.play()
        animationview.loopMode = .repeatBackwards(10)
        animationview.animationSpeed = 0.3
        
    }
 */
    func logo(){
        let animationview = AnimationView(name: "39612-location-animation")
        animationview.frame = CGRect(x: 0, y: 150, width: 428, height: 330)
        //animationview.center = self.view.center
        animationview.contentMode = .scaleAspectFill
        view.addSubview(animationview)
        animationview.play()
        animationview.loopMode = .loop
        animationview.animationSpeed = 1.5
        
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
