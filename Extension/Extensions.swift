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
    
    /// appleLogoImageView.rounded(with: 30, at: [.allTop, .allBottom])
    func rounded(with radius: CGFloat,at corners: [ViewCornerType]) {
        roundedCorner(with: radius, topLeft: corners.contains(.allTop) || corners.contains(.allLeft),
                      topRight: corners.contains(.allTop) || corners.contains(.allRight),
                      bottomLeft: corners.contains(.allBottom) || corners.contains(.allLeft),
                      bottomRight: corners.contains(.allBottom) || corners.contains(.allRight))
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
    /*
     UIView replaces with = RegisterPageView
     let newView = RegisterPageView.instanceFromNib()
     */
    
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

extension UIColor {
    /*
     let myColor = UIColor(hexFromString: "4F9BF5")
     let myColor1 = UIColor(hexFromString: "#4F9BF5")
     let myColor2 = UIColor(hexFromString: "#4F9BF5", alpha: 0.5)
     */
    
    convenience init(hexFromString:String, alpha:CGFloat = 1.0) {
        var cString:String = hexFromString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        var rgbValue:UInt64 = 10066329
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if ((cString.count) == 6) {
            Scanner(string: cString).scanHexInt64(&rgbValue)
        }
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}

extension UserDefaults {
    /*
      UserDefaults.standard.setObjectValue(taylor, forKey: key)
      taylor object of class/struct
      key = "save-data"
      make sure class/struct must be codable protocol adopt
     print(FileManager.default.urls(for: .preferencePanesDirectory, in: .userDomainMask).first!)  ---> See Saved Data
     */
   
    open func setObjectValue<T: Codable>(_ value: T, forKey key: String) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(value)
            UserDefaults.standard.setValue(data, forKey: key)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    /*
     UserDefaults.standard.getObjectValue(ofType: Person.self, forKey: key)
     person is class/struct
     key = "save-data"
     */
    
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
    /*
      if let img = UserDefaults.standard.imageForKey(key: key) {
      appleLogoImageView.image = img
      }
     */
    
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
    
    /*
    UserDefaults.standard.setImage(image: UIImage(named: "naveenPhotos"), forKey: key)
     */
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
    /*
      let strDate = "2020-08-10 15:00:00"
      let date = strDate.toDate(format: "yyyy-MM-dd HH:mm:ss")
      let strDate2 = date?.toString(format: "yyyy-MM-dd HH:mm:ss")
     */
    
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


extension String {
    func isValidEmailAddress() -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
    
    func isValidPhone() -> Bool {
        let PHONE_REGEX = "^\\d{3}\\d{3}\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result = phoneTest.evaluate(with: self)
        return result
    }
}

//-----------ViewController extension ------------------------
extension UIViewController {
    var isModal: Bool {
        let presentingIsModal = presentingViewController != nil
        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController
        return presentingIsModal || presentingIsNavigation || presentingIsTabBar
    }
    
    /*
     showSettingsAlert(toAccess: "Hi there") { (_ didAllow) in
     print("Successed!!") }
     */
    
    func showSettingsAlert(toAccess access: String,_ completionHandler: @escaping (_ accessGranted: Bool) -> Void) {
        let alert = UIAlertController(title: nil, message: "This app requires access to \(access) to proceed. Go to Settings to grant access.", preferredStyle: .alert)
        if
            let settings = URL(string: UIApplication.openSettingsURLString),
            UIApplication.shared.canOpenURL(settings) {
            alert.addAction(UIAlertAction(title: "Open Settings", style: .default) { action in
                completionHandler(false)
                UIApplication.shared.open(settings)
            })
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { action in
            completionHandler(false)
        })
        present(alert, animated: true)
    }
    
    /*
     emailText = emailTextField.text
     let value = isValidEmailAddress(emailAddressString: emailText)
     */
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            if results.count == 0
            {
                returnValue = false
            }
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        return  returnValue
    }
    ///  dismissKeyboardOnViewTap()
    @objc func dismissKeyboardOnViewTap() {
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_ :))))
    }
    
    @objc private func dismissKeyboard(_ sender: UIGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    struct Loader {
        static var loaderViewBG: UIView?
    }
    ///   self.showLoader()
    func showLoader() {
        if let window = UIWindow.appWindow() {
            let view = UIView(frame: window.bounds)
            view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            var aIV: UIActivityIndicatorView!
            if #available(iOS 13.0, *) {
                aIV = UIActivityIndicatorView(style: .large)
            } else {
                // Fallback on earlier versions
                aIV = UIActivityIndicatorView(style: .whiteLarge)
            }
            view.addSubview(aIV)
            aIV.center = view.center
            aIV.startAnimating()
            window.addSubview(view)
            Loader.loaderViewBG = view
        }
    }
    
    ///  self.hideLoader()
    func hideLoader() {
        if let ldView = Loader.loaderViewBG {
            ldView.removeFromSuperview()
        }
    }
    
    ///   goBackToPreviousScreen()
    @objc func goBackToPreviousScreen() {
        if let navVC = self.navigationController {
            if navVC.viewControllers.count == 1 {
                self.dismiss(animated: true)
            } else {
                navVC.popViewController(animated: true)
            }
        } else {
            self.dismiss(animated: true)
        }
    }
    
    @objc func goBackToPreviousScreen(_ block: (() -> ())? = nil) {
        if let navVC = self.navigationController {
            if navVC.viewControllers.count == 1 {
                navVC.dismiss(animated: true, completion: block)
            } else {
                navVC.popViewController(animated: true)
                DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                    if let block = block {
                        block()
                    }
                })
            }
        } else {
            self.dismiss(animated: true, completion: block)
        }
    }
    
    private struct ToastHolder {
        static var toast: UILabel! = nil
        static var toastSeverity: ToastSeverityType! = nil
    }
    
    /*
      showToast(message: "iOS Developer")
      showToast(message: "Naveen kumar", toastType: .appTheme, removeAfter: 5)
     */

    func showToast(message: String, toastType: ToastSeverityType = .appTheme, removeAfter duration: Double? = nil) {
        if let window = UIWindow.appWindow() {
            if ToastHolder.toast == nil {
                let width = window.frame.width - 40
                let textLabel = UILabel()
                ToastHolder.toastSeverity = toastType
                setToastColor(toastType, textLabel)
                textLabel.text = message
                textLabel.clipsToBounds = true
                textLabel.layer.cornerRadius = 10
                textLabel.numberOfLines = 0
                textLabel.font = UIFont(name: "Avenir", size: 16)
                textLabel.textAlignment = .center
                ToastHolder.toast = textLabel
                let height = textLabel.textHeight(withWidth: width)
                textLabel.frame = CGRect(x: 20, y: -height, width: width, height: height + 10)
                window.addSubview(textLabel)
                UIView.animate(withDuration: 0.25, animations: {
                    textLabel.transform = CGAffineTransform.init(translationX: 0, y: height + 40)
                }) { (_) in
                    if let duration = duration {
                        if duration > 0 {
                            DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: {
                                self.removeToast()
                            })
                        }
                    } else {
                        DispatchQueue.main.asyncAfter(deadline: .now() + Double(message.count)/15, execute: {
                            self.removeToast()
                        })
                    }
                }
            }
        }
    }
    
    fileprivate func setToastColor(_ toastType: ToastSeverityType, _ textLabel: UILabel) {
        switch toastType {
        case .correct:
            textLabel.backgroundColor = Global.shared.colorSchemeGreen
            textLabel.textColor = .darkGray
            break
        case .warning:
            textLabel.backgroundColor = Global.shared.colorSchemeYellow
            textLabel.textColor = .darkGray
            break
        case .incorrect:
            textLabel.backgroundColor = UIColor.red
            textLabel.textColor = .white
            break
        case .appTheme:
            textLabel.backgroundColor = Global.shared.primarycolorScheme
            textLabel.textColor = Global.shared.colorSchemeWhite
            break
        }
    }
    
    /*
       removeToast()
       removeToast(after: 5, message: "Failed !!", toastType: .incorrect, removeWithColorChange: true)
     */
    func removeToast(after duration: Double = 0, message: String = "", toastType: ToastSeverityType = .appTheme, removeWithColorChange: Bool = false) {
        if let textLabel = ToastHolder.toast {
            textLabel.text = message
            if removeWithColorChange {
                setToastColor(toastType, textLabel)
            } else {
                if let toastType = ToastHolder.toastSeverity {
                    setToastColor(toastType, textLabel)
                } else {
                    setToastColor(toastType, textLabel)
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                UIView.animate(withDuration: 0.25, animations: {
                    textLabel.transform = CGAffineTransform.identity
                }, completion: { (_) in
                    ToastHolder.toast = nil
                    textLabel.removeFromSuperview()
                })
            }
        }
    }
}

extension UIWindow {
    class func appWindow() -> UIWindow? {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.connectedScenes.filter({$0.activationState == .foregroundActive}).map({$0 as? UIWindowScene}).compactMap({$0}).first?.windows.filter({$0.isKeyWindow}).first
        } else {
            return UIApplication.shared.keyWindow!
        }
    }
}

extension UILabel {
    func textHeight(withWidth width: CGFloat) -> CGFloat {
        guard let text = text else { return 0 }
        return text.height(withWidth: width, font: font)
    }
}

extension String {
    func height(withWidth width: CGFloat, font: UIFont) -> CGFloat {
        let maxSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let actualSize = self.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], attributes: [.font: font], context: nil)
        return actualSize.height
    }
}

//-----------ViewController extension (end)---------

extension UIDevice {
    /*
     import AudioToolbox
     UIDevice.vibrate() --> call this way when you call
     */
    static func vibrate() {
        AudioServicesPlaySystemSound(1519)
    }
}

extension UIApplication {
    /*
     if let topController = UIApplication.topViewController() {
     self.view.backgroundColor = .red
     topController.view.backgroundColor = .blue
     print(topController)
     }
     */
 
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

extension NSMutableAttributedString {
    func setUnderLineForText(textForAttribute: String, withColor color: UIColor, withFontName fontName: String, fontSize:Int) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        self.addAttribute(NSAttributedString.Key.font, value: UIFont(name: fontName, size: CGFloat(fontSize)) ?? "", range: range)
        self.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
    }
    
    func setSimpleForText(textForAttribute: String, withColor color: UIColor, fontName: String, fontSize:Int){
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        self.addAttribute(NSAttributedString.Key.font, value: UIFont(name: fontName, size: CGFloat(fontSize))!, range: range)
    }
    
    /*
     let stringValue = "By continuing,you agree to our\nTerms & Conditions and Privacy Policy."
     let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: stringValue)
     attributedString.setSimpleForText(textForAttribute: stringValue, withColor: .red, fontName: "Poppins-SemiBold", fontSize: 18)
     attributedString.setUnderLineForText(textForAttribute: "Terms & Conditions", withColor: #colorLiteral(red: 0.3882352941, green: 0.3882352941, blue: 0.4, alpha: 1), withFontName: "Poppins-SemiBold", fontSize: 12)
     attributedString.setUnderLineForText(textForAttribute: "Privacy Policy", withColor: #colorLiteral(red: 0.3882352941, green: 0.3882352941, blue: 0.4, alpha: 1), withFontName: "Poppins-SemiBold", fontSize: 12)
     termLabel.attributedText = attributedString //termLabel is Label Outlet....
     */
}

extension CALayer {
    /*
     let caBasisAnimation = CABasicAnimation(keyPath: CALayer.CALayerAnimations_Kyes.rotation)
     caBasisAnimation.fromValue = 0
     caBasisAnimation.toValue = 100
     caBasisAnimation.repeatCount = .infinity
     caBasisAnimation.duration = 50
     self.contentView.layer.add(caBasisAnimation, forKey: nil)
     */
    
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


// #-#-#-#-#-#-#-#-#-#-#-#-#
// MARK: UIDevice extensions
// #-#-#-#-#-#-#-#-#-#-#-#-#

public extension UIDevice {
    /*
     let deviceType = UIDevice().type
     switch deviceType {
     case .iPhoneX:
     print("HI")
     default:
     break
     }
     */
    
    var type: Model {
        var systemInfo = utsname()
        uname(&systemInfo)
        let modelCode = withUnsafePointer(to: &systemInfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) {
                ptr in String.init(validatingUTF8: ptr)
            }
        }
        
        let modelMap : [String: Model] = [
            //Simulator
            "i386"      : .simulator,
            "x86_64"    : .simulator,
            
            //iPod
            "iPod1,1"   : .iPod1,
            "iPod2,1"   : .iPod2,
            "iPod3,1"   : .iPod3,
            "iPod4,1"   : .iPod4,
            "iPod5,1"   : .iPod5,
            "iPod7,1"   : .iPod6,
            "iPod9,1"   : .iPod7,
            
            //iPad
            "iPad2,1"   : .iPad2,
            "iPad2,2"   : .iPad2,
            "iPad2,3"   : .iPad2,
            "iPad2,4"   : .iPad2,
            "iPad3,1"   : .iPad3,
            "iPad3,2"   : .iPad3,
            "iPad3,3"   : .iPad3,
            "iPad3,4"   : .iPad4,
            "iPad3,5"   : .iPad4,
            "iPad3,6"   : .iPad4,
            "iPad6,11"  : .iPad5, //iPad 2017
            "iPad6,12"  : .iPad5,
            "iPad7,5"   : .iPad6, //iPad 2018
            "iPad7,6"   : .iPad6,
            "iPad7,11"  : .iPad7, //iPad 2019
            "iPad7,12"  : .iPad7,
            "iPad11,6"  : .iPad8, //iPad 2020
            "iPad11,7"  : .iPad8,
            
            //iPad Mini
            "iPad2,5"   : .iPadMini,
            "iPad2,6"   : .iPadMini,
            "iPad2,7"   : .iPadMini,
            "iPad4,4"   : .iPadMini2,
            "iPad4,5"   : .iPadMini2,
            "iPad4,6"   : .iPadMini2,
            "iPad4,7"   : .iPadMini3,
            "iPad4,8"   : .iPadMini3,
            "iPad4,9"   : .iPadMini3,
            "iPad5,1"   : .iPadMini4,
            "iPad5,2"   : .iPadMini4,
            "iPad11,1"  : .iPadMini5,
            "iPad11,2"  : .iPadMini5,
            
            //iPad Pro
            "iPad6,3"   : .iPadPro9_7,
            "iPad6,4"   : .iPadPro9_7,
            "iPad7,3"   : .iPadPro10_5,
            "iPad7,4"   : .iPadPro10_5,
            "iPad6,7"   : .iPadPro12_9,
            "iPad6,8"   : .iPadPro12_9,
            "iPad7,1"   : .iPadPro2_12_9,
            "iPad7,2"   : .iPadPro2_12_9,
            "iPad8,1"   : .iPadPro11,
            "iPad8,2"   : .iPadPro11,
            "iPad8,3"   : .iPadPro11,
            "iPad8,4"   : .iPadPro11,
            "iPad8,9"   : .iPadPro2_11,
            "iPad8,10"  : .iPadPro2_11,
            "iPad8,5"   : .iPadPro3_12_9,
            "iPad8,6"   : .iPadPro3_12_9,
            "iPad8,7"   : .iPadPro3_12_9,
            "iPad8,8"   : .iPadPro3_12_9,
            "iPad8,11"  : .iPadPro4_12_9,
            "iPad8,12"  : .iPadPro4_12_9,
            
            //iPad Air
            "iPad4,1"   : .iPadAir,
            "iPad4,2"   : .iPadAir,
            "iPad4,3"   : .iPadAir,
            "iPad5,3"   : .iPadAir2,
            "iPad5,4"   : .iPadAir2,
            "iPad11,3"  : .iPadAir3,
            "iPad11,4"  : .iPadAir3,
            "iPad13,1"  : .iPadAir4,
            "iPad13,2"  : .iPadAir4,
            
            
            //iPhone
            "iPhone3,1" : .iPhone4,
            "iPhone3,2" : .iPhone4,
            "iPhone3,3" : .iPhone4,
            "iPhone4,1" : .iPhone4S,
            "iPhone5,1" : .iPhone5,
            "iPhone5,2" : .iPhone5,
            "iPhone5,3" : .iPhone5C,
            "iPhone5,4" : .iPhone5C,
            "iPhone6,1" : .iPhone5S,
            "iPhone6,2" : .iPhone5S,
            "iPhone7,1" : .iPhone6Plus,
            "iPhone7,2" : .iPhone6,
            "iPhone8,1" : .iPhone6S,
            "iPhone8,2" : .iPhone6SPlus,
            "iPhone8,4" : .iPhoneSE,
            "iPhone9,1" : .iPhone7,
            "iPhone9,3" : .iPhone7,
            "iPhone9,2" : .iPhone7Plus,
            "iPhone9,4" : .iPhone7Plus,
            "iPhone10,1" : .iPhone8,
            "iPhone10,4" : .iPhone8,
            "iPhone10,2" : .iPhone8Plus,
            "iPhone10,5" : .iPhone8Plus,
            "iPhone10,3" : .iPhoneX,
            "iPhone10,6" : .iPhoneX,
            "iPhone11,2" : .iPhoneXS,
            "iPhone11,4" : .iPhoneXSMax,
            "iPhone11,6" : .iPhoneXSMax,
            "iPhone11,8" : .iPhoneXR,
            "iPhone12,1" : .iPhone11,
            "iPhone12,3" : .iPhone11Pro,
            "iPhone12,5" : .iPhone11ProMax,
            "iPhone12,8" : .iPhoneSE2,
            "iPhone13,1" : .iPhone12Mini,
            "iPhone13,2" : .iPhone12,
            "iPhone13,3" : .iPhone12Pro,
            "iPhone13,4" : .iPhone12ProMax,
            
            // Apple Watch
            "Watch1,1" : .AppleWatch1,
            "Watch1,2" : .AppleWatch1,
            "Watch2,6" : .AppleWatchS1,
            "Watch2,7" : .AppleWatchS1,
            "Watch2,3" : .AppleWatchS2,
            "Watch2,4" : .AppleWatchS2,
            "Watch3,1" : .AppleWatchS3,
            "Watch3,2" : .AppleWatchS3,
            "Watch3,3" : .AppleWatchS3,
            "Watch3,4" : .AppleWatchS3,
            "Watch4,1" : .AppleWatchS4,
            "Watch4,2" : .AppleWatchS4,
            "Watch4,3" : .AppleWatchS4,
            "Watch4,4" : .AppleWatchS4,
            "Watch5,1" : .AppleWatchS5,
            "Watch5,2" : .AppleWatchS5,
            "Watch5,3" : .AppleWatchS5,
            "Watch5,4" : .AppleWatchS5,
            "Watch5,9" : .AppleWatchSE,
            "Watch5,10" : .AppleWatchSE,
            "Watch5,11" : .AppleWatchSE,
            "Watch5,12" : .AppleWatchSE,
            "Watch6,1" : .AppleWatchS6,
            "Watch6,2" : .AppleWatchS6,
            "Watch6,3" : .AppleWatchS6,
            "Watch6,4" : .AppleWatchS6,
            
            //Apple TV
            "AppleTV1,1" : .AppleTV1,
            "AppleTV2,1" : .AppleTV2,
            "AppleTV3,1" : .AppleTV3,
            "AppleTV3,2" : .AppleTV3,
            "AppleTV5,3" : .AppleTV4,
            "AppleTV6,2" : .AppleTV_4K
        ]
        
        if let model = modelMap[String.init(validatingUTF8: modelCode!)!] {
            if model == .simulator {
                if let simModelCode = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
                    if let simModel = modelMap[String.init(validatingUTF8: simModelCode)!] {
                        return simModel
                    }
                }
            }
            return model
        }
        return Model.unrecognized
    }
}


// MARK:- Extension For CUSTOM Of VIEW
extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}


 // MARK:- Letter spacing for Label
extension UILabel {
    @IBInspectable
    var letterSpace: CGFloat {
        set {
            let attributedString: NSMutableAttributedString!
            if let currentAttrString = attributedText {
                attributedString = NSMutableAttributedString(attributedString: currentAttrString)
            } else {
                attributedString = NSMutableAttributedString(string: text ?? "")
                text = nil
            }
            attributedString.addAttribute(NSAttributedString.Key.kern,
                                          value: newValue,
                                          range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }

        get {
            if let currentLetterSpace = attributedText?.attribute(NSAttributedString.Key.kern, at: 0, effectiveRange: .none) as? CGFloat {
                return currentLetterSpace
            } else {
                return 0
            }
        }
    }
}


 // MARK:- Set Corner-Radius to UIView
extension UIView {
    /*
     theView.roundCorners(corners: [.topLeft, .topRight], radius: 3.0)
     */
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
