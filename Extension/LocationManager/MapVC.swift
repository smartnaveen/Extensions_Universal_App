//
//  mapVC.swift
//  Firestore Demo
//
//  Created by Naveen Kumar on 19/10/21.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapVC: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var tfSearch: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        LocationManager.shared.askPermission()
        LocationManager.shared.delegate = self
        
//        self.mapView.isMyLocationEnabled = true
        self.mapView.delegate = self
        self.mapView.clear()
        tfSearch.delegate = self

        /*
        mapView.camera = GMSCameraPosition.camera(withTarget: CLLocationCoordinate2D(latitude: 26.753009492980073, longitude: 84.97144150417115), zoom: 12)

         
         let marker = GMSMarker()
         marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
         marker.title = "Sydney"
         marker.snippet = "Australia"
         marker.map = mapView
         */
    }
    
    
    @IBAction func gpsButton(_ sender: UIButton) {
        LocationManager.shared.askPermission()
        LocationManager.shared.delegate = self
        self.mapView.delegate = self
        self.mapView.clear()
    }
    
    //MARK: Find Location
    func getLocation(_ address: GMSAddress) -> String {
        var strAddress : String = ""
        if address.thoroughfare != nil {
            strAddress = strAddress + address.thoroughfare! + ", "
        }
        if address.locality != nil {
            strAddress = strAddress + address.locality! + ", "
        }
        if address.administrativeArea != nil {
            strAddress = strAddress + address.administrativeArea! + " "
        }
        
//        if address.subLocality != nil {
//            strAddress = strAddress + address.subLocality!
//        }
        if address.postalCode != nil {
            strAddress = strAddress + address.postalCode! + ", "
        }
        if address.country != nil {
            strAddress = strAddress + address.country!
        }
                
        return strAddress
    }

}


// MARK: - Map Delegate
extension MapVC: GMSMapViewDelegate{
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        print("idleAt")
        self.findPlace(position.target) { (result) in
            let getFullAddress = self.getLocation(result)
            self.tfSearch.text = getFullAddress
            print(getFullAddress)
        }
    }
    
    //MARK: Show Camera Location
    func showCurrentLocation(_ locationLat: Double, _ locationLng: Double, markerImage:String) {
        self.mapView.clear()
        let lattitude = locationLat
        let longitude = locationLng
        let imageView = UIImageView(image: UIImage(named: markerImage))
//        DispatchQueue.main.async {
            imageView.frame = CGRect(x: 0, y: 0, width: 5, height: 8)
            imageView.contentMode = .center
            let markerView = UIImageView(image: imageView.image)
            let center = CLLocationCoordinate2D(latitude: lattitude , longitude: longitude )
            let marker = GMSMarker()
            marker.position = center
            marker.map = self.mapView
            marker.iconView = markerView
            let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: lattitude , longitude: longitude , zoom: 16)
            self.mapView.animate(to: camera)
            self.mapView.camera = camera
        
        // Use where map not implemented
        /*
         self.findPlace(CLLocationCoordinate2D(latitude: locationLat, longitude: locationLng)) { (result) in
             let getFullAddress = self.getLocation(result)
             print(getFullAddress)
         }
         */
//        }
    }
    
    
    func findPlace(_ withCoordinate: CLLocationCoordinate2D, completion: @escaping (GMSAddress)->Void) {
        let geoCoder = GMSGeocoder()
        geoCoder.reverseGeocodeCoordinate(withCoordinate) { (response, error) in
            if error == nil {
                if let result = response?.firstResult() {
                    completion(result)
                }
            }else{
                print(error!.localizedDescription)
            }
        }
    }
}


// MARK: - Places Delegate
extension MapVC: GMSAutocompleteViewControllerDelegate{
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print(error.localizedDescription)
       // dismiss(animated: true, completion: nil)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
//        self.tfAddress1.text    = place.name
//        self.objAddress.address = place.formattedAddress ?? ""
//        self.objAddress.lng     = "\(place.coordinate.longitude)"
//        self.objAddress.lat     = "\(place.coordinate.latitude)"
//        self.mapView.delegate = self

        self.showCurrentLocation(place.coordinate.latitude, place.coordinate.longitude, markerImage: "pin_ren")

        self.dismiss(animated: true) {
            print("place.formattedAddress...\(String(describing: place.formattedAddress))")
            self.tfSearch.text = "\(place.formattedAddress ?? "")"
        }
    }
    
    //Open google Autocomplete
    func openGoogleAutoComplete() {
        let gmsAutoCompleteVC = GMSAutocompleteViewController()
        gmsAutoCompleteVC.delegate = self
        let filter = GMSAutocompleteFilter()
        if let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String {
            filter.country = countryCode
        }
//        gmsAutoCompleteVC.autocompleteFilter = filter
        gmsAutoCompleteVC.modalPresentationStyle = .fullScreen
        self.present(gmsAutoCompleteVC, animated: true, completion: nil)
    }
}


// MARK: - CLLocation Delegate
extension MapVC: LocationPermission {
    func locationDenied() {
        let alertController = UIAlertController(title: "TITLE", message: "Please go to Settings and turn on the permissions", preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                })
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(settingsAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func getCoordinate(lat: CLLocationDegrees, long: CLLocationDegrees) {
        self.showCurrentLocation(Double(lat), Double(long), markerImage: "pin_ren")

        print("============================================================")
        print(lat)
        print("============================================================")
        print(long)
    }

}


// MARK: - TextField Delegate
extension MapVC: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == tfSearch{
            self.openGoogleAutoComplete()
        }
    }
    
}


// MARK: - OPEN GOOGLE MAPS/ APPLE MAPS TO DRAW ROUTES
 func showRouteOnMap(pickupCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D) {
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
            UIApplication.shared.openURL(URL(string:"comgooglemaps://?saddr=\(pickupCoordinate.latitude),\(pickupCoordinate.longitude)&daddr=\(destinationCoordinate.latitude),\(destinationCoordinate.longitude)&directionsmode=driving&zoom=14&views=traffic")!)
        }
        else {
            print("Can't use comgooglemaps://");
        }
    }

/*
        //find route
        let loc1 = CLLocationCoordinate2D.init(latitude: self.currentLatitude, longitude: self.currentLongitude)
        let loc2 = CLLocationCoordinate2D.init(latitude: Double(selectedHCenter.first?.latitude ?? "") ?? 0.0, longitude: Double(selectedHCenter.first?.longitude ?? "") ?? 0.0)
       // self.showRouteOnMap(pickupCoordinate: loc1, destinationCoordinate: loc2)
*/

// MARK: - APPLE MAPS
        let loc2 = CLLocationCoordinate2D.init(latitude: Double(selectedHCenter.first?.latitude ?? "") ?? 0.0, longitude: Double(selectedHCenter.first?.longitude ?? "") ?? 0.0)
        let coordinate = loc2
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary: nil))
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])

