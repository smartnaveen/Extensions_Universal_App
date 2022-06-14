//
//  PlacesVC.swift
//  Firestore Demo
//
//  Created by Naveen Kumar on 20/10/21.
//

import UIKit
import GooglePlaces

class PlacesVC: UIViewController {

    @IBOutlet weak var tf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tf.delegate = self
    }
}

//MARK: For Address
extension PlacesVC: GMSAutocompleteViewControllerDelegate{
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print(error.localizedDescription)
       // dismiss(animated: true, completion: nil)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        print(place.name ?? "",place.formattedAddress ?? "", place.coordinate.longitude , place.coordinate.latitude)
//        self.tfAddress1.text    = place.name
//        self.objAddress.address = place.formattedAddress ?? ""
//        self.objAddress.lng     = "\(place.coordinate.longitude)"
//        self.objAddress.lat     = "\(place.coordinate.latitude)"
                
        
//        self.getCurrentLocation(locationLat: place.coordinate.latitude, locationLng: place.coordinate.longitude)
        
        self.dismiss(animated: true) {
            print("place.formattedAddress...\(String(describing: place.formattedAddress))")
            self.tf.text = place.formattedAddress
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
        gmsAutoCompleteVC.autocompleteFilter = filter
        gmsAutoCompleteVC.modalPresentationStyle = .fullScreen
        self.present(gmsAutoCompleteVC, animated: true, completion: nil)
    }
}

extension PlacesVC: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == tf{
            self.openGoogleAutoComplete()
        }
    }
    
}
