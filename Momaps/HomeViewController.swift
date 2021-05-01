//
//  HomeViewController.swift
//  Momaps
//
//  Created by Cosmo on 4/26/21.
//

import UIKit
import Parse
import NotificationBannerSwift
import Lottie
import Mapbox



extension UIViewController{
    func HideKeyboard() {
        let Tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self , action: #selector(DismissKeyboard))
        view.addGestureRecognizer(Tap)
    }
    @objc func DismissKeyboard(){
        view.endEditing(true)
    }
}
class HomeViewController: UIViewController, MGLMapViewDelegate {
    
    @IBAction func logoutButton(_ sender: Any) {
        PFUser.logOut()
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(identifier: "LoginViewController")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else { return }
        
        delegate.window?.rootViewController = loginViewController
    }
    
    override func viewDidLoad() {
        
        self.HideKeyboard()
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        let user = PFUser.current()!.username as! String
        let banner = GrowingNotificationBanner(title: "Welcome back!", subtitle: "Hey \(user)! - explore new locations and navigate it through our step-by-step navigation feature!", leftView: nil, rightView: nil, style: .success, colors: nil)
        banner.show()
        // Do any additional setup after loading the view.
        
        //dark mode style
        let url = URL(string: "mapbox://styles/mapbox/dark-v10")
        let mapView = MGLMapView(frame: view.bounds, styleURL: url)
        
        //initial map loads like this
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.setCenter(CLLocationCoordinate2D(latitude: 40.71, longitude: -74.00), zoomLevel: 9, animated: false)
        view.addSubview(mapView)
        
        //testing annotations
        let annotation = MGLPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 40.77014, longitude: -73.97480)
        annotation.title = "Central Park"
        annotation.subtitle = "This is where my friends and I go to eat lunch"
        mapView.addAnnotation(annotation)
        
        mapView.delegate = self
        
        //  display the user's location
        mapView.showsUserLocation = true

    }
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
    // Always allow callouts to popup when annotations are tapped.
    return true
    }
    
    func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
    let camera = MGLMapCamera(lookingAtCenter: annotation.coordinate, fromDistance: 4500, pitch: 15, heading: 180)
    mapView.fly(to: camera, withDuration: 4,
    peakAltitude: 3000, completionHandler: nil)
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

