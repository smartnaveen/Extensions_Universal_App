//
//  InstagramHelper.swift
//  Extension
//
//  Created by Naveen Kumar on 25/02/23.
//

import UIKit
import Foundation
import Photos

class InstagramHelper: NSObject, UIDocumentInteractionControllerDelegate {
    
    var cont = UIViewController()
    
    // singleton manager
    class var sharedManager: InstagramHelper {
        struct Singleton {
            static let instance = InstagramHelper()
        }
        return Singleton.instance
    }
    
    func postImageToInstagramWithCaption(imageInstagram: UIImage, controller: UIViewController) {
        cont = controller
        let status = PHPhotoLibrary.authorizationStatus()
        if (status == PHAuthorizationStatus.authorized) {
            // Access has been granted.
            self.shareToInstagram(imageInstagram)
        }else if (status == PHAuthorizationStatus.denied) {
            print("Access has been denied")
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: { _ in
                    // Handle
                })
            }
        }else if (status == PHAuthorizationStatus.notDetermined) {
            PHPhotoLibrary.requestAuthorization({ (newStatus) in
                if (newStatus == PHAuthorizationStatus.authorized) {
                    self.shareToInstagram(imageInstagram)
                }else {
                    print("Please Allow Access To Photos To Share")
                }
            })
        }else if (status == PHAuthorizationStatus.restricted) {
            print("Restricted access - normally won't happen")
        }
    }
    
    func shareToInstagram(_ theImageToShare: UIImage){
        self.saveToCameraRoll(image: theImageToShare) { (theUrl, assId) in
            DispatchQueue.main.async {
                if let assIdd = assId{
                    if let instagram = URL(string: "instagram://library?LocalIdentifier=\(assIdd)"){
                        if UIApplication.shared.canOpenURL(instagram) {
                            UIApplication.shared.open(instagram)
                        }else {
                            UtilityMangr.shared.showAlert(title: "Warning", msg: "Cannot open Instagram, be sure Instagram is installed on your device.", vwController: self.cont)
                        }
                    }
                }
            }
        }
    }
    
    func saveToCameraRoll(image: UIImage, completion: @escaping (URL?, _ assId: String?) -> Void) {
        var placeHolder: PHObjectPlaceholder? = nil
        var asId: String = ""
        
        PHPhotoLibrary.shared().performChanges({
            let creationRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
            placeHolder = creationRequest.placeholderForCreatedAsset!
            asId = creationRequest.placeholderForCreatedAsset?.localIdentifier ?? ""
        }, completionHandler: { success, error in
            guard success, let placeholder = placeHolder else {
                completion(nil, nil)
                return
            }
            let assets = PHAsset.fetchAssets(withLocalIdentifiers: [placeholder.localIdentifier], options: nil)
            guard let asset = assets.firstObject else {
                completion(nil, nil)
                return
            }
            asset.requestContentEditingInput(with: nil, completionHandler: { (editingInput, _) in
                completion(editingInput?.fullSizeImageURL, asId)
            })
        })
    }
}


