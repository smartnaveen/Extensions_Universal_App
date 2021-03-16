//
//  Extensions.swift
//  Extension
//
//  Created by Mr. Naveen Kumar on 11/03/21.
//

import Foundation
import UIKit
import AudioToolbox

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    /// appleLogoImageView.setImageColor(color: .black)
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
    /// appleLogoImageView.loadImagesUsingCache(urlString: "", defaultImage: UIImage(systemName: ""))
    func loadImagesUsingCache(urlString: String, defaultImage: UIImage? = nil) {
        if let image = defaultImage {
            self.image = image
            return
        }
        //getting cached images
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cachedImage
            return
        }
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil {
                print(error ?? "Downloading Profile Image Failed!")
                return
            }
            DispatchQueue.main.async {
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                    self.image = downloadedImage
                }
            }
        })
        task.resume()
    }
    /// appleLogoImageView.changeImageColor(to: .black)
    func changeImageColor(to color: UIColor) {
        if let currentImage = self.image {
            let img = currentImage.withRenderingMode(.alwaysTemplate)
            self.image = img
            self.tintColor = color
        }
    }
}

extension UIView {
    /// appleLogoImageView.makeCircular(radius: 12)
    /// make circulat width==height
    func makeCircular(radius: CGFloat? = nil) {
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        if let radius = radius {
            self.layer.cornerRadius = radius
        } else {
            self.layer.cornerRadius = self.frame.size.width/2
        }
    }
    
    /// appleLogoImageView.rounded(with: 20, at: [.topLeft, .topRight])
    func rounded(with radius: CGFloat,at corners: [UIRectCorner]) {
        roundedCorner(with: radius, topLeft: corners.contains(.topLeft), topRight: corners.contains(.topRight), bottomLeft: corners.contains(.bottomLeft), bottomRight: corners.contains(.bottomRight))
    }
    func roundedCorner(with radius: CGFloat, topLeft: Bool = false, topRight: Bool = false, bottomLeft: Bool = false, bottomRight: Bool = false) {
        if #available(iOS 11.0, *) {
            self.layer.cornerRadius = radius
            self.layer.masksToBounds = true
            self.clipsToBounds = true

            var corners = CACornerMask()
            if topLeft {
                corners.insert(.layerMinXMinYCorner)
            }
            if topRight {
                corners.insert(.layerMaxXMinYCorner)
            }
            if bottomLeft {
                corners.insert(.layerMinXMaxYCorner)
            }
            if bottomRight {
                corners.insert(.layerMaxXMaxYCorner)
            }
            self.layer.maskedCorners = corners
        } else {
            var corners = UIRectCorner()
            if topLeft {
                corners.insert(.topLeft)
            }
            if topRight {
                corners.insert(.topRight)
            }
            if bottomLeft {
                corners.insert(.bottomLeft)
            }
            if bottomRight {
                corners.insert(.bottomRight)
            }
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = self.bounds
            maskLayer.path = path.cgPath
            self.layer.mask = maskLayer
        }
    }
}

enum Views: String {
    /// load xib file (load custom UIView)
    /// let newView = Views.view1.getView() ---- USES
    case view1 = "NewView" // Change View1 to be the name of your nib
    case view2 = "View2" // Change View2 to be the name of another nib

    func getView() -> UIView? {
        return Bundle.main.loadNibNamed(self.rawValue, owner: nil, options: nil)?.first as? UIView
    }
}

extension UIView {
    /// UIView replaces with = RegisterPageView
    /// let newView = RegisterPageView.instanceFromNib()
    /// load custom Xib File
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "RegisterPageView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
}

extension UIColor {
    /// self.view.backgroundColor = UIColor.init(105, 60, 114)
    convenience init(_ r: CGFloat,_ g: CGFloat,_ b: CGFloat,_ a: CGFloat = 1) {
        let alpha = (a >= 1) ? 1 : (a < 0 ? 0 : a)
        if r >= 0, r <= 1, g >= 0, g <= 1, b >= 0, b <= 1  {
            self.init(red: r, green: g, blue: b, alpha: alpha)
        } else {
            self.init(red: r/255, green: g/255, blue: b/255, alpha: alpha)
        }
    }
    /// range of rgbValue is 0...1
    /// Both case alpha set default is 1
    convenience init(rgbValue v: CGFloat, alpha a: CGFloat = 1) {
        let alpha = (a >= 1) ? 1 : (a < 0 ? 0 : a)
        self.init(v, v, v, alpha)
    }
}

extension UserDefaults {
    /// UserDefaults.standard.setObjectValue(taylor, forKey: key)
    /// taylor object of class/struct
    /// key = "save-data"
    /// make sure class/struct must be codable protocol adopt
    open func setObjectValue<T: Codable>(_ value: T, forKey key: String) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(value)
            UserDefaults.standard.setValue(data, forKey: key)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    ///UserDefaults.standard.getObjectValue(ofType: Person.self, forKey: key)
    /// person is class/struct
    /// key = "save-data"
    open func getObjectValue<T: Codable>(ofType type: T.Type, forKey key: String) -> T? {
        if let data = UserDefaults.standard.data(forKey: key) {
            do {
                let decoder = JSONDecoder()
                let value = try decoder.decode(type, from: data)
                return value
            } catch let error {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}

extension UserDefaults {
    /// if let img = UserDefaults.standard.imageForKey(key: key) {
    /// appleLogoImageView.image = img
    /// }
    func imageForKey(key: String) -> UIImage? {
        var image: UIImage?
        if let imageData = data(forKey: key) {
            do {
                if let loadedStrings = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(imageData) as? UIImage {
                    image = loadedStrings
                }
            } catch {
                print("Couldn't get Image file.")
            }
        }
        return image
    }
    
    /// UserDefaults.standard.setImage(image: UIImage(named: "naveenPhotos"), forKey: key)
    func setImage(image: UIImage?, forKey key: String) {
        var imageData: NSData?
        if let image = image {
            do {
                imageData = try NSKeyedArchiver.archivedData(withRootObject: image, requiringSecureCoding: false) as NSData
                set(imageData, forKey: key)
            } catch {
                print("Couldn't Save Image file.")
            }
        }
    }
}


extension String {
    /// let str1 = "  a b c d e   \n"
    /// let str2 = str1.trimmed
    var trimmed: String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    mutating func trim() {
        self = self.trimmed
    }
}

// -----------------------String.toDate(…) and Date.toString(…) --------
extension String {
    /// let strDate = "2020-08-10 15:00:00"
    /// let date = strDate.toDate(format: "yyyy-MM-dd HH:mm:ss")
    /// let strDate2 = date?.toString(format: "yyyy-MM-dd HH:mm:ss")
    
    func toDate(format: String) -> Date? {
        let df = DateFormatter()
        df.dateFormat = format
        return df.date(from: self)
    }
}

extension Date {
    func toString(format: String) -> String {
        let df = DateFormatter()
        df.dateFormat = format
        return df.string(from: self)
    }
}
// ---------------End

extension UIDevice {
    /// UIDevice.vibrate() --> call this way when you call
    /// import AudioToolbox
    static func vibrate() {
        AudioServicesPlaySystemSound(1519)
    }
}

extension UIApplication {
    /// if let topController = UIApplication.topViewController() {
    /// self.view.backgroundColor = .red
    /// topController.view.backgroundColor = .blue
    /// print(topController)
    /// }
    class func topViewController(controller: UIViewController? = UIWindow.key?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}

extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
        return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
        return UIApplication.shared.keyWindow
        }
    }
}


extension CALayer {
    /// let caBasisAnimation = CABasicAnimation(keyPath: CALayer.CALayerAnimations_Kyes.rotation)
   /// caBasisAnimation.fromValue = 0
   /// caBasisAnimation.toValue = 100
   /// caBasisAnimation.repeatCount = .infinity
   ///caBasisAnimation.duration = 50
    /// self.contentView.layer.add(caBasisAnimation, forKey: nil)
    struct CALayerAnimations_Kyes {
        static let transform      = "transform"
        static let translation    = "transform.translation"
        static let translationX   = "transform.translation.x"
        static let translationY   = "transform.translation.y"
        static let opacity        = "opacity"
        static let scale          = "transform.scale"
        static let rotation       = "transform.rotation"
        static let rotationX      = "transform.rotation.x"
        static let rotationY      = "transform.rotation.y"
        static let rotationZ      = "transform.rotation.z"
        static let position       = "position"
    }
}
