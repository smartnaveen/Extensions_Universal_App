//
//  ShareHelper.swift
//  Extension
//
//  Created by Naveen Kumar on 25/02/23.
//

import Foundation
import UIKit
import FBSDKShareKit

protocol ShareImageViaFacebookDelegate: AnyObject {
    func didCompleteWithResults()
    func didFailWithError(_ error: String)
    func sharerDidCancel()
}

class ShareHelper: NSObject, UIDocumentInteractionControllerDelegate{
    
    static var shared = ShareHelper()
    weak var delegate: ShareImageViaFacebookDelegate?
    var documentInteractionController: UIDocumentInteractionController?
    
    func shareImageViaWhatsapp(image: UIImage, controller: UIViewController) {
       
        let urlWhats = "whatsapp://send?source_application="
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters:CharacterSet.urlQueryAllowed){
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL as URL) {
                    guard let imageData = image.pngData() else { debugPrint("Cannot convert image to data!"); return }
                    let tempFile = URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("Documents/MSA.igo")
                    do {
                        try imageData.write(to: tempFile, options: .atomic)
                        documentInteractionController = UIDocumentInteractionController(url: tempFile)
                        documentInteractionController?.uti = "net.whatsapp.image"
                        documentInteractionController?.presentOpenInMenu(from: CGRect.zero, in: controller.view, animated: true)
                    } catch {
                        UtilityMangr.shared.showAlert(title: "Warning", msg: "There was an error while processing, please contact our support team.", vwController: controller)
                        return
                    }
                } else {
                    UtilityMangr.shared.showAlert(title: "Warning", msg: "Cannot open Whatsapp, be sure Whatsapp is installed on your device.", vwController: controller)
                }
            }
        }
    }
    
    func shareImageViaFacebook(image: UIImage, fromViewController: UIViewController) {
        let sharePhoto = SharePhoto(image: image, userGenerated: true)
        let content = SharePhotoContent()
        content.photos = [sharePhoto]
        
        let dialog = ShareDialog(fromViewController: fromViewController, content: content, delegate: (fromViewController as? SharingDelegate))
        dialog.delegate = self
        dialog.fromViewController = fromViewController
        dialog.shareContent = content
        dialog.mode = .shareSheet
        dialog.show()
    }
    
    func shareImageToFbStory(image: UIImage, fromViewController: UIViewController) {
        if let urlScheme = URL(string: "facebook-stories://share?source_application=") {
            if UIApplication.shared.canOpenURL(urlScheme) {
                guard let imageData: Data = image.pngData() else { return }
                let items = [
                    ["com.facebook.sharedSticker.backgroundImage": imageData,
                     "com.facebook.sharedSticker.appID": AppConstant.KFbAppId
                    ]
                ]
//                let pasteboardOptions = [UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(60*5)]
                UIPasteboard.general.setItems(items, options: [:])
                UIApplication.shared.open(urlScheme, options: [:], completionHandler: nil)
            }else{
                UtilityMangr.shared.showAlert(title: "Warning", msg: "Cannot open Facebook, be sure Facebook is installed on your device.", vwController: fromViewController)
            }
        }
    }
    
    func shareImageToInstagramStory(image: UIImage, fromViewController: UIViewController) {
        if let urlScheme = URL(string: "instagram-stories://share?source_application=") {
            if UIApplication.shared.canOpenURL(urlScheme) {
                guard let imageData: Data = image.pngData() else { return }
                let items = [["com.instagram.sharedSticker.backgroundImage": imageData]]
//                let pasteboardOptions = [UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(60*5)]
                UIPasteboard.general.setItems(items, options: [:])
                UIApplication.shared.open(urlScheme, options: [:], completionHandler: nil)
            }else{
                UtilityMangr.shared.showAlert(title: "Warning", msg: "Cannot open Instagram, be sure Instagram is installed on your device.", vwController: fromViewController)
            }
        }
    }
    
    func shareImageViaActivity(text: String? = nil, image: UIImage? = nil, url: URL? = nil, onView: UIViewController) {
        var objectsToShare: [Any] = []
        if let safeImg = image{
            objectsToShare.append(safeImg)
        }
        
        if let safeText = text{
            objectsToShare.append(safeText)
        }
        
        if let safeUrl = url{
            objectsToShare.append(safeUrl)
        }
        
        let vc = UIActivityViewController(activityItems: objectsToShare, applicationActivities: [])
        // so that iPads won't crash
        if UIDevice.current.userInterfaceIdiom == .pad {
            if let popoverController = vc.popoverPresentationController {
                popoverController.sourceView = onView.view
                popoverController.sourceRect = CGRect(x: onView.view.bounds.midX, y: onView.view.bounds.maxY, width: 0, height: 0)
                popoverController.permittedArrowDirections = []
            }
        }
        vc.excludedActivityTypes = [UIActivity.ActivityType.saveToCameraRoll]
        onView.present(vc, animated: true)
    }
}

// MARK: - Facebook Delegate
extension ShareHelper: SharingDelegate{
    func sharer(_ sharer: FBSDKShareKit.Sharing, didCompleteWithResults results: [String : Any]) {
        delegate?.didCompleteWithResults()
    }
    
    func sharer(_ sharer: FBSDKShareKit.Sharing, didFailWithError error: Error) {
        print(error)
        delegate?.didFailWithError(error.localizedDescription)
    }
    
    func sharerDidCancel(_ sharer: FBSDKShareKit.Sharing) {
        delegate?.sharerDidCancel()
    }
    
    
}
