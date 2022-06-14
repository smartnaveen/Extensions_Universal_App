//
//  ContactPicker&Message.swift
//  Extension
//
//  Created by Naveen Kumar on 01/10/21.
//

import UIKit
import ContactsUI
import MessageUI

/*
class ViewController: UIViewController, UITextFieldDelegate {
    
    var arrContact = [String]()
    @IBOutlet weak var tf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
       
    }
    
    
    @IBAction func alertButton(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AlertVC") as! AlertVC
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
    
    
    // Contacts
    @IBAction func btnShare(_ sender: UIButton) {
        let authorizationStatus = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
        
        CNContactStore().requestAccess(for: .contacts) { (access, error) in
            if access { // allow
                DispatchQueue.main.async {
                    let vc = CNContactPickerViewController()
                    vc.delegate = self
                    self.present(vc, animated: true, completion: nil)
                }
                
            }else { // Not allow
                if authorizationStatus == CNAuthorizationStatus.denied {
                    DispatchQueue.main.async {
                        self.showSettingsAlert()
                    }
                }
            }
        }
    }
    
    // SMS
    
    @IBAction func btnSms(_ sender: UIButton) {
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = "566556564"
            controller.recipients = arrContact
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    
    func showSettingsAlert() {
        let alert = UIAlertController(title: nil, message: "This app requires access to Contacts to proceed. Go to Settings to grant access.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Open Settings", style: .default) { action in
            self.gotoAppPrivacySettings()
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { action in
        })
        present(alert, animated: true)
    }
    
    
    func gotoAppPrivacySettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString),
            UIApplication.shared.canOpenURL(url) else {
                assertionFailure("Not able to open App privacy settings")
                return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

}

// MARK: - Picking Contacts
extension ViewController: CNContactPickerDelegate {
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
        print(contacts)
        self.arrContact.removeAll()
        for cont in contacts {
            let userPhone = cont.phoneNumbers.first?.value.stringValue
            let safePhoneNumber = getNumberFromContact(contactNumber: userPhone ?? "")
            print(safePhoneNumber)
            self.arrContact.append(safePhoneNumber)
        }
    }
    
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        print("Cancelled...")
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contactProperty: CNContactProperty) {
        
    }
    
    func getNumberFromContact(contactNumber: String) -> String {
        //UPDATE YOUR NUMBER SELECTION LOGIC AND PERFORM ACTION WITH THE SELECTED NUMBER
        var contactNumber = contactNumber.replacingOccurrences(of: "-", with: "")
        contactNumber = contactNumber.replacingOccurrences(of: "(", with: "")
        contactNumber = contactNumber.replacingOccurrences(of: ")", with: "")
        contactNumber = contactNumber.replacingOccurrences(of: " ", with: "")
        
        if contactNumber.count >= 10 {
            return contactNumber
        }else {
            print("Selected contact does not have a valid number")
            return ""
            //  self.popUpMessageError(value: 10, message: "Selected contact does not have a valid number")
        }
        
    }
}

// MARK: - Message Method
extension ViewController: MFMessageComposeViewControllerDelegate {
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
           switch (result) {
           case .cancelled:
               print("Message was cancelled")
           case .failed:
               print("Message failed")
           case .sent:
               print("Message was sent")
           default:
               return
           }
           dismiss(animated: true, completion: nil)
       }
    
    
}



*/
