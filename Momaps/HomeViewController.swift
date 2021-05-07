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
import MapboxCoreNavigation
import MapboxNavigation
import MapboxDirections



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
    var mapView: NavigationMapView!
    var routeOptions: NavigationRouteOptions?
    var route: Route?
    
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
        mapView = NavigationMapView(frame: view.bounds, styleURL: url)
        
        //initial map loads like this
        //zoom level gets closer as you increase the number
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.setCenter(CLLocationCoordinate2D(latitude: 40.74699, longitude: -73.98742), zoomLevel: 12, animated: false)
        view.addSubview(mapView)
        
        /*
        //testing annotations
        let annotation = MGLPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 40.77014, longitude: -73.97480)
        annotation.title = "Central Park"
        annotation.subtitle = "This is where my friends and I go to eat dinner"
        mapView.addAnnotation(annotation)
        */
        
        //testing out create annotation
        createAnnotation(mapView, _lat: 40.77014, _long: -73.97480, _name: "Central Park", _description: "This is where my friends and I go to eat dinner")
        
        
        createAnnotation(mapView, _lat: 40.7115, _long: -74.00, _name: "Hangout", _description: "This is where my friends and I hangout")
        
        mapView.delegate = self
        
        //  display the user's location
        mapView.showsUserLocation = true
        // tracks the user's location on the map
        //mapView.setUserTrackingMode(.follow, animated: true, completionHandler: nil)

    }
    
    
    func createAnnotation(_ mapView: MGLMapView, _lat: Double, _long: Double, _name: String, _description: String) {
        let annotation = MGLPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: _lat, longitude: _long)
        annotation.title = _name
        annotation.subtitle = _description
        mapView.addAnnotation(annotation)
    }
        
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
    // Always allow callouts to popup when annotations are tapped.
    return true
    }
    
    func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
        /*//tries to find the distance in meters between 2 coordinates
        let from = CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
        let user_pos = mapView.userLocation?.coordinate
        let to = CLLocation(latitude: user_pos!.latitude, longitude: user_pos!.longitude)
        let _distance = from.distance(from: to)
        */
        //print(_distance)
        
        /*   //commenting this out because across distance maybe bugged
        let camera = MGLMapCamera(lookingAtCenter: annotation.coordinate, acrossDistance: (_distance*2), pitch: 15, heading: 180)
    mapView.fly(to: camera, withDuration: 4,
    peakAltitude: 3000, completionHandler: nil)
    */
    
        let coordinate = annotation.coordinate
        
        
         
        if let origin = mapView.userLocation?.coordinate {
        // Calculate the route from the user's location to the set destination
        calculateRoute(from: origin, to: coordinate)
        } else {
        print("Failed to get user location, make sure to allow location access for this application.")
        }
        
    }
    
    // Calculate route to be used for navigation
    func calculateRoute(from origin: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) {
        // Coordinate accuracy is how close the route must come to the waypoint in order to be considered viable. It is measured in meters. A negative value indicates that the route is viable regardless of how far the route is from the waypoint.
        let origin = Waypoint(coordinate: origin, coordinateAccuracy: -1, name: "Start")
        let destination = Waypoint(coordinate: destination, coordinateAccuracy: -1, name: "Finish")

        // Specify that the route is intended for automobiles avoiding traffic
        let routeOptions = NavigationRouteOptions(waypoints: [origin, destination], profileIdentifier: .automobileAvoidingTraffic)

        // Generate the route object and draw it on the map
        Directions.shared.calculate(routeOptions) { [weak self] (session, result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let response):
                guard let route = response.routes?.first, let strongSelf = self else {
                    return
                }
                
                strongSelf.route = route
                strongSelf.routeOptions = routeOptions
                
                
                // Draw the route on the map after creating it
                strongSelf.drawRoute(route: route)
                
                // Show destination waypoint on the map
                strongSelf.mapView.showWaypoints(on: route)
            
            }
        }
    }
    
    func drawRoute(route: Route) {
        guard let routeShape = route.shape, routeShape.coordinates.count > 0 else { return }
        // Convert the route’s coordinates into a polyline
        var routeCoordinates = routeShape.coordinates
        let polyline = MGLPolylineFeature(coordinates: &routeCoordinates, count: UInt(routeCoordinates.count))

        // If there's already a route line on the map, reset its shape to the new route
        if let source = mapView.style?.source(withIdentifier: "route-source") as? MGLShapeSource {
            source.shape = polyline
        } else {
            let source = MGLShapeSource(identifier: "route-source", features: [polyline], options: nil)

            // Customize the route line color and width
            let lineStyle = MGLLineStyleLayer(identifier: "route-style", source: source)
            lineStyle.lineColor = NSExpression(forConstantValue: #colorLiteral(red: 0.1897518039, green: 0.3010634184, blue: 0.7994888425, alpha: 1))
            lineStyle.lineWidth = NSExpression(forConstantValue: 3)

            // Add the source and style layer of the route line to the map
            mapView.style?.addSource(source)
            mapView.style?.addLayer(lineStyle)
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

