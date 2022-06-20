//
//  AppManager.swift
//  Rentee
//
//  Created by Apple02 on 3/26/19.
//  Copyright © 2019 Sunfocus Solutions Pvt Ltd. All rights reserved.
//

import UIKit
import DateToolsSwift
import UserNotifications



class AppManager: NSObject {
    
    class var shared: AppManager{
        struct  Singlton{
            static let instance = AppManager()
        }
        return Singlton.instance
    }
    
    class func isProfileComplete() -> Bool {
        return UserDefaults.standard.bool(forKey: GConstant.kIsUploadeProfile) ? true:false
    }
    class func isLogin() -> Bool {
        return UserDefaults.standard.bool(forKey: GConstant.kIsLogin) ? true:false
    }
    
    class func isFirstLanch() -> Bool {
        return UserDefaults.standard.bool(forKey: GConstant.kFirstLanch) ? true:false
    }
    
    class func isSetUpTabBar() -> Bool {
        return UserDefaults.standard.bool(forKey: GConstant.kIsSetupTabbar) ? true:false
    }
    
    class func getDeviceToken() -> String {
//        return "7D8176397D220F594E6F3EAAF77B1B097EE011B04A6B5F1688ECBE5DEF692C93"
        if let deviceToken = UserDefaults.standard.value(forKey: GConstant.kDeviceToken) as? String {
            if deviceToken.count > 0 {
                return deviceToken
            }
            else{
                return ""
            }
        }else{
            return ""
        }
    }
    
    class func getAuthenticationToken() -> String {
        if let token = UserDefaults.standard.value(forKey: GConstant.kAuthToken) as? String {
            return "Bearer \(token)"

        }else{
            return ""
        }
        
        //return "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZmQ5YWY1ODliMzM3NWE5MTNlZTBjOGQiLCJmaXJzdG5hbWUiOiJQYW5rYWoiLCJsYXN0bmFtZSI6Ikt1bWFyIiwiZW1haWwiOiJzZnMucGFua2FqMjBAZ21haWwuY29tIiwiZ2VuZGVyIjoibWFsZSIsImRvYiI6IjE5OTUtMTItMTZUMDA6MDA6MDAuMDAwWiIsImNvdW50cnlfY29kZSI6Iis5MSIsInBob25lX251bWJlciI6Ijg3MDA1MzkzNjYiLCJwcm9maWxlIjoiIiwidXNlcl90eXBlIjoibWVuIiwiZGVmYXVsdF9wcm9maWxlIjp0cnVlLCJhZGRyZXNzX2lkIjoiIiwiaWF0IjoxNjE0NTkxNjEzLCJhdWQiOiJTcVRvc2RzZEtlTnBSb0plQ3QifQ.Ao8EGV6WTnsXSAot9Ng9ei4Uj2NoBhHStEQFhmFI89Y"
    }

    static func getUserID() -> String {
        return UserDefaults.standard.value(forKey: GConstant.kUserID) as! String
    }
    
    
    class func getLoggedInUser() {
        if let user = UserDefaults.standard.object(forKey: GConstant.kCurrentUser) as? Data {
            if let userData = NSKeyedUnarchiver.unarchiveObject(with: user) as? UserModel {
                GConstant.loggedInUser = UserModel.init()
                GConstant.loggedInUser = userData
            }
        }
    }
    
    
    //   MARK: Set User Data
    class func saveSignUpUser(currentUser: UserModel) {
        let userData = NSKeyedArchiver.archivedData(withRootObject: currentUser)
        UserDefaults.SFSDefault(setObject: userData, forKey: GConstant.kSignUpUser)
    }
    
    class func getSignUpUser() {
        if let user = UserDefaults.standard.object(forKey: GConstant.kSignUpUser) as? Data {
            if let userData = NSKeyedUnarchiver.unarchiveObject(with: user) as? UserModel {
                GConstant.signUpUser = UserModel.init()
                GConstant.signUpUser = userData
            }
        }
    }
    
    
    //   MARK: Set User Data
    class func saveLoggedInUser(currentUser: UserModel) {
        let userData = NSKeyedArchiver.archivedData(withRootObject: currentUser)
        UserDefaults.SFSDefault(setObject: userData, forKey: GConstant.kCurrentUser)
    }
    
    class func checkMaxLength(textField: UITextField!, maxLength: Int , range : NSRange) -> Bool {
        if (textField.text?.count)! >= maxLength && range.length == 0 {
            return false
        }else {
            return true
        }
    }
    
    
    //MARK: Set Autoutolayout In Sub View
    class func setSubViewlayout(_ subView: UIView , mainView : UIView){
        subView.translatesAutoresizingMaskIntoConstraints = false
        mainView.addConstraint(NSLayoutConstraint(item: subView, attribute: .top, relatedBy: .equal, toItem: mainView, attribute: .top, multiplier: 1.0, constant: 0.0))
        
        mainView.addConstraint(NSLayoutConstraint(item: subView, attribute: .leading, relatedBy: .equal, toItem: mainView, attribute: .leading, multiplier: 1.0, constant: 0.0))
        
        mainView.addConstraint(NSLayoutConstraint(item: subView, attribute: .bottom, relatedBy: .equal, toItem: mainView, attribute: .bottom, multiplier: 1.0, constant: 0.0))
        mainView.addConstraint(NSLayoutConstraint(item: subView, attribute: .trailing, relatedBy: .equal, toItem: mainView, attribute: .trailing, multiplier: 1.0, constant: 0.0))
        
    }
    
    class func calculateDate(startTimeStamp : Double , timeFormat:String ) -> String {
        let date = Date.init(timeIntervalSince1970: startTimeStamp / 1000)
        return date.format(with: timeFormat)
    }
    
    func convertDateFormater(_ date: String, toFormat: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = toFormat
        return dateFormatter.string(from: date ?? Date())
    }
    
    enum NotificationIdentifier: String{
        case start = "START_DRIVE_IDENTIFIER"
        case end = "END_DRIVE_IDENTIFIER"
    }
    
    enum NotificationTypes: String{
        case start      = "Journey has been started."
        case end        = "Journey has been completed."
        case onGoing    = "Your previous open journey completed."
    }
    
    //MARK: Local Notification
    func localNotification(type: NotificationTypes){
        
        let notification = UNUserNotificationCenter.current()
        notification.getPendingNotificationRequests { (notifications) in
            if notifications.count == 0 {
                let content = UNMutableNotificationContent()
                content.body = type.rawValue
                content.sound = .default
                content.badge = 0
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)

                let identifier = type == .start ? NotificationIdentifier.start.rawValue : NotificationIdentifier.end.rawValue
                let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
                notification.add(request, withCompletionHandler: { error in
                    if error != nil {
                        print("something went wrong")
                    }
                })
            }
        }
        
    }
    
    //MARK:- setDate
    func setDate(createdDate:String, inputFormatt: String, OutputFormatt: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormatt

        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = OutputFormatt

        let date1 = dateFormatter.date(from:createdDate)
        if date1 != nil
        {
            let endDate =  dateFormatter1.string(from: date1!)
            return endDate
        }
        else
        {
            return ""
        }
    }
    
    //MARK: Show Error View
    
    func showView(inView: UIView,showMessage:String) {
        let alertview = UIView.init()
        //        let screenSize = UIScreen.main.bounds.width
        alertview.frame = CGRect.init(x: 0, y: 64, width: inView.frame.size.width, height: inView.frame.size.height )
        alertview.backgroundColor = UIColor.init(red: 101/255, green: 192/255, blue: 125/255, alpha: 1.0)
        let messageImage = UIImageView.init(image: #imageLiteral(resourceName: "New option"))
        messageImage.frame = CGRect.init(x: (alertview.frame.size.width-70)/2, y: (alertview.frame.size.height/2)-100, width: 70, height: 70)
        let messageLabel = UILabel.init()
        messageLabel.frame = CGRect.init(x: Int(alertview.frame.origin.x+20), y: (Int(messageImage.frame.origin.y+messageImage.frame.size.height+20.0)), width: (Int(alertview.frame.size.width-40.0)), height: 200)
        messageLabel.backgroundColor = UIColor.black
        messageLabel.numberOfLines = 4
        messageLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        messageLabel.sizeToFit()
        messageLabel.textAlignment = .center
        messageLabel.text = showMessage
        alertview.addSubview(messageImage)
        alertview.addSubview(messageLabel)
        inView.addSubview(alertview)
    }
    
    //MARK: Left View to textfield
    func setLeftViewOnTextField(textField: UITextField) -> Void {
        let paddingView = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: 10.0, height: 20.0))
        textField.leftView = paddingView
        textField.leftViewMode = UITextField.ViewMode.always
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.cornerRadius = 5.0
    }
    
    //Convert to json .......
    func json(from object:Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
    func setRightImageViewOnTextField(textField: UITextField, WithImage imageName:UIImage) -> Void {
        let paddingView = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: 40.0, height: textField.frame.size.height))
        let paddingImage = UIImageView(frame: CGRect(x: 5, y: 5, width: textField.frame.size.height-10, height: textField.frame.size.height-10))
        paddingImage.image = imageName
        paddingImage.contentMode = UIView.ContentMode.center
        paddingView.addSubview(paddingImage)
        textField.rightView = paddingView
        textField.rightViewMode = UITextField.ViewMode.always
    }
    
    func setLeftViewOnTextView(textView: UITextView) -> Void {
        textView.contentInset = .init(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.cornerRadius = 5.0
    }
    
    //MARK: Shake textfield/textview
    func shakeTextField(textField: UITextField, withText:String, currentText:String) -> Void {
        textField.text = ""
        textField.attributedPlaceholder = NSAttributedString(string: currentText,
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        let isSecured = textField.isSecureTextEntry
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.10
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint:CGPoint.init(x: textField.center.x - 10, y: textField.center.y) )
        animation.toValue = NSValue(cgPoint: CGPoint.init(x: textField.center.x + 10, y: textField.center.y) )
        textField.layer.add(animation, forKey: "position")
        if isSecured {
            textField.isSecureTextEntry = false
        }
        textField.attributedPlaceholder = NSAttributedString(string: withText,
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            textField.attributedPlaceholder = NSAttributedString(string: currentText,
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            //  textField.placeholder = placeholder
            if isSecured {
                textField.isSecureTextEntry = true
            }
        }
        
    }
    
    //MARK: Resize Image
    
    func resizeImage(image : UIImage , targetSize : CGSize) -> UIImage{
        let originalSize:CGSize =  image.size
        
        let widthRatio :CGFloat = targetSize.width/originalSize.width
        let heightRatio :CGFloat = targetSize.height/originalSize.height
        
        var newSize : CGSize!
        if widthRatio > heightRatio {
            newSize =  CGSize(width : originalSize.width*heightRatio ,  height : originalSize.height * heightRatio)
        }
        else{
            newSize = CGSize(width : originalSize.width * widthRatio , height : originalSize.height*widthRatio)
        }
        
        // preparing rect for new image
        
        let rect:CGRect =  CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)
        image .draw(in: rect)
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }

    
    func shakeTextView(textView: UITextView
        , withText:String, currentText:String) -> Void {
        textView.text = currentText
        textView.textColor =  UIColor.darkText
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.10
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint:CGPoint.init(x: textView.center.x - 10, y: textView.center.y) )
        animation.toValue = NSValue(cgPoint: CGPoint.init(x: textView.center.x + 10, y: textView.center.y) )
        textView.layer.add(animation, forKey: "position")
        textView.text = withText
        textView.textColor =  UIColor.red
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            textView.text = currentText
            textView.textColor = UIColor.darkText
            //  textField.placeholder = placeholder
        }
        
    }
    
    func shakeButton(button: UIButton){
        let shake:CABasicAnimation = CABasicAnimation(keyPath: "position")
        shake.duration = 0.10
        shake.repeatCount = 2
        shake.autoreverses = true
        let from_point:CGPoint = CGPoint.init(x: button.center.x - 10, y: button.center.y )
        let from_value:NSValue = NSValue(cgPoint: from_point)
        let to_point:CGPoint = CGPoint.init(x: button.center.x + 10, y: button.center.y )
        let to_value:NSValue = NSValue(cgPoint: to_point)
        shake.fromValue = from_value
        shake.toValue = to_value
        button.layer.add(shake, forKey: "position")
    }
    
    //MARK: Login/Sign Up Validations
    
    //  E-mail checking
    func isValidEmail(testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    func isValidPassword(testStr:String) -> Bool {
        print("validate password: \(testStr)")
        let passwprdRegEx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwprdRegEx)
        let result = passwordTest.evaluate(with: testStr)
        return result
    }
    
    func validate(password: String) -> Bool{  // Abcdef11
        let regularExpression = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        let passwordValidation = NSPredicate.init(format: "SELF MATCHES %@", regularExpression)
        return passwordValidation.evaluate(with: password)
    }
    
    
    //   Phone Number validation
    func validateNumber(value: String) -> Bool {
        let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result = phoneTest.evaluate(with: value)
        return result
    }
    
    class func getErrorMessage(_ error : Error) -> String {
        var errorMessage: NSString = NSString()
        switch error._code {
        case -998:
            errorMessage = "Unknow Error";
            break;
        case -1000:
            errorMessage = "Bad URL request";
            break;
        case -1001:
            errorMessage = "The request time out";
            break;
        case -1002:
            errorMessage = "Unsupported URL";
            break;
        case -1003:
            errorMessage = "The host could not be found";
            break;
        case -1004:
            errorMessage = "The host could not be connect, Please try after some time";
            break;
        case -1005:
            errorMessage = "The network connection lost, Please try agian";
            break;
        case -1009:
            errorMessage = "The internet connection appear to be  offline";
            break;
        case -1103:
            errorMessage = "Data lenght exceed to maximum defined data";
            break;
        case -1100:
            errorMessage = "File does not exist";
            break;
        case -1013:
            errorMessage = "User authentication required";
            break;
        case -2102:
            errorMessage = "The request time out";
            break;
            
        default:
            errorMessage = "Server Error";
            break;
        }
        return errorMessage as String
        
    }
}



extension UserDefaults{
    class func SFSDefault(setIntegerValue integer: Int , forKey key : String){
        UserDefaults.standard.set(integer, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func SFSDefault(setObject object: Any , forKey key : String){
        UserDefaults.standard.set(object, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func SFSDefault(setValue object: Any , forKey key : String){
        UserDefaults.standard.setValue(object, forKey: key)
        UserDefaults.standard.synchronize()
    }
    class func SFSDefault(setBool boolObject:Bool  , forKey key : String){
        UserDefaults.standard.set(boolObject, forKey : key)
        UserDefaults.standard.synchronize()
    }
    
    class func SFSDefault(integerForKey  key: String) -> Int{
        let integerValue : Int = UserDefaults.standard.integer(forKey: key) as Int
        UserDefaults.standard.synchronize()
        return integerValue
    }
    
    class func SFSDefault(objectForKey key: String) -> Any{
        let object : Any = UserDefaults.standard.object(forKey: key)! as Any
        UserDefaults.standard.synchronize()
        return object
    }
    
    class func SFSDefault(valueForKey  key: String) -> Any{
        let value : Any = UserDefaults.standard.value(forKey: key) as Any
        UserDefaults.standard.synchronize()
        return value
    }
    
    class func SFSDefault(stringforKey  key: String) -> String {
        let value = UserDefaults.standard.string(forKey: key) ?? ""
        UserDefaults.standard.synchronize()
        return value
    }
    
    class func SFSDefault(boolForKey  key : String) -> Bool{
        let booleanValue : Bool = UserDefaults.standard.bool(forKey: key) as Bool
        UserDefaults.standard.synchronize()
        return booleanValue
    }
    
    class func SFSDefault(removeObjectForKey key: String)
    {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
    //Save no-premitive data
    class func SFSDefault(setArchivedDataObject object: Any , forKey key : String){
        if let data  = NSKeyedArchiver.archivedData(withRootObject: object) as? Data {
            UserDefaults.standard.set(data, forKey: key)
            UserDefaults.standard.synchronize()
        }
    }
    class func SFSDefault(getUnArchiveObjectforKey key: String) -> Any?{
        var objectValue : Any?
        if  let storedData  = UserDefaults.standard.object(forKey: key) as? Data{
            objectValue   =  NSKeyedUnarchiver.unarchiveObject(with: storedData) as Any?
            UserDefaults.standard.synchronize()
            return objectValue!;
        }
        else{
            objectValue = "" as Any?
            return objectValue!
        }
    }
}



// MARK: - Use in login / Signup Screen
/*
 let authToken = data["token"].stringValue
 let userData = UserModel.init(data)
 AppManager.saveLoggedInUser(currentUser: userData)
 AppManager.getLoggedInUser()
 UserDefaults.SFSDefault(setValue: authToken, forKey: GConstant.kAuthToken)
 UserDefaults.SFSDefault(setValue: true, forKey: GConstant.kIsLogin)
 
 
 
 let data = dict["data"]
 let authToken = data["token"].stringValue
 let userData = UserModel.init(data)
 AppManager.saveLoggedInUser(currentUser: userData)
 AppManager.getLoggedInUser()
 UserDefaults.SFSDefault(setValue: authToken, forKey: GConstant.kAuthToken)
 UserDefaults.SFSDefault(setValue: true, forKey: GConstant.kIsLogin)
 AppManager.getLoggedInUser()
 GFunction.shared.removeUserDefaults(key: GConstant.kSignUpUser)

*/

// MARK: - How to use
/*
 AppManager.getLoggedInUser()
 */
