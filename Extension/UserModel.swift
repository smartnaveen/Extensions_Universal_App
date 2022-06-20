//
//  UserModel.swift
//  Stylist
//
//  Created by 09Viju on 19/10/20.
//  Copyright © 2020 SFS. All rights reserved.
//

import Foundation
import SwiftyJSON

class UserModel: NSObject, NSCoding {
    var userID                      = String()
    var firstname                   = String()
    var fullName                    = String()
    var lastname                    = String()
    var middlename                  = String()
    var relation                    = String()
    var userType                    = String()
    var defaultProfile              = Bool()
    var email                       = String()
    var password                    = String()
    var ssnNumber                   = String()
    var newPassword                 = String()
    var confirmPassword             = String()
    var gender                      = String()
    var dob                         = String()
    var convertedDob                = String()
    var country_code                = String()
    var phone_number                = String()
    var farmatedNumber                = String()
    var isVerifyNumber              = NSNumber()
    var isVerifyEmail               = NSNumber()
    var codeWithFlag                = String()
    var categoryId                  = String()
    var specializationId            = String()
    var categoryName                = String()
    var specializationName          = String()
    var experience                  = String()
    var experienceKey               = String()
    var address                     = String()
    var address1                    = String()
    var address2                    = String()
    var city                        = String()
    var state                       = String()
    var zip_code                    = String()
    var privacy_policy              = NSNumber()
    var terms_condition             = NSNumber()
    var lat                         = String()
    var lng                         = String()
    var location                    = String()
    var device_token                = String()
    var device_type                 = "ios"
    var profile                     = String()
    var isCheckNumber               = false
    //var preferences                 = PreferencesModel()
    var preferences                 = [String]()

    var orderType                   = [String]()
    var address_id                  = String()
    var default_profile_id          = String()
    var age_group          = String()
    
    var defaultProfileData = DefaultProfileData()
    
    override init() {
        
    }
    
    init(_ dictionary: JSON){
        self.profile                   = dictionary["profile"].stringValue
        self.dob                       = dictionary["dob"].stringValue
        self.city                      = dictionary["city"].stringValue
        self.state                     = dictionary["state"].stringValue
        self.userType                      = dictionary["user_type"].stringValue
        self.relation                     = dictionary["relation"].stringValue
        self.defaultProfile                     = dictionary["default_profile"].boolValue
        self.zip_code                  = dictionary["zip_code"].stringValue
        self.privacy_policy            = dictionary["privacy_policy"].numberValue
        self.terms_condition           = dictionary["terms_condition"].numberValue
        self.lat                       = dictionary["lat"].stringValue
        self.lng                       = dictionary["lng"].stringValue
        
        for order in (dictionary["order_type"].arrayValue){
            self.orderType.append(order.stringValue)
        }
        
        self.userID                 = dictionary["_id"].stringValue
        self.firstname              = dictionary["firstname"].stringValue
        self.lastname               = dictionary["lastname"].stringValue
        self.middlename             = dictionary["middlename"].stringValue
        self.email                  = dictionary["email"].stringValue
        self.gender                 = dictionary["gender"].stringValue
        self.country_code           = dictionary["country_code"].stringValue
        self.phone_number           = dictionary["phone_number"].stringValue
        self.specializationId       = dictionary["specialization"].stringValue
        self.categoryId             = dictionary["category"].stringValue
        self.experienceKey          = dictionary["experience"].stringValue
        self.address                = dictionary["address"].stringValue
        self.address_id                = dictionary["address_id"].stringValue
        self.default_profile_id                = dictionary["default_profile_id"].stringValue
        
        self.age_group                = dictionary["age_group"].stringValue
        
        if dictionary["preference"].exists() {
            let prefer = dictionary["preference"]
//            self.preferences = PreferencesModel.init(prefer)
            for objPreference in prefer.arrayValue {
                self.preferences.append(objPreference.stringValue)
            }
        }
        
        if dictionary["default_profile_data"].exists() {
            let default_profile_data = dictionary["default_profile_data"]
            self.defaultProfileData = DefaultProfileData.init(default_profile_data)
        }
    }
    
    //MARK: NSEncoding
    func encode(with coder: NSCoder) {
        coder.encode(self.profile , forKey: "profile")
        coder.encode(self.convertedDob , forKey: "convertedDob")
        coder.encode(self.farmatedNumber , forKey: "farmatedNumber")
        coder.encode(self.defaultProfileData , forKey: "defaultProfileData")
        coder.encode(self.dob , forKey: "dob")
        coder.encode(self.city , forKey: "city")
        coder.encode(self.state , forKey: "state")
        coder.encode(self.zip_code , forKey: "zip_code")
        coder.encode(self.password , forKey: "password")
        coder.encode(self.privacy_policy , forKey: "privacy_policy")
        coder.encode(self.terms_condition , forKey: "terms_condition")
        coder.encode(self.lat , forKey: "lat")
        coder.encode(self.lng , forKey: "lng")
        coder.encode(self.userID , forKey: "userID")
        coder.encode(self.firstname , forKey: "firstname")
        coder.encode(self.middlename , forKey: "middlename")
        coder.encode(self.lastname , forKey: "lastname")
        coder.encode(self.email , forKey: "email")
        coder.encode(self.gender , forKey: "gender")
        coder.encode(self.country_code , forKey: "country_code")
        coder.encode(self.address_id , forKey: "address_id")
        coder.encode(self.phone_number , forKey: "phone_number")
        coder.encode(self.specializationId , forKey: "specializationId")
        coder.encode(self.categoryId , forKey: "categoryId")
        coder.encode(self.experienceKey , forKey: "experienceKey")
        coder.encode(self.address , forKey: "address")
        coder.encode(self.isVerifyNumber , forKey: "isVerifyNumber")
        coder.encode(self.isVerifyEmail , forKey: "isVerifyEmail")
        coder.encode(self.categoryName , forKey: "categoryName")
        coder.encode(self.specializationName , forKey: "specializationName")
        coder.encode(self.experience , forKey: "experience")
        coder.encode(self.address1 , forKey: "address1")
        coder.encode(self.address2 , forKey: "address2")
        coder.encode(self.orderType , forKey: "orderType")
        coder.encode(self.preferences , forKey: "preferences")
        coder.encode(self.default_profile_id , forKey: "default_profile_id")
        coder.encode(self.age_group , forKey: "age_group")
        coder.encode(self.userType , forKey: "userType")
        coder.encode(self.ssnNumber , forKey: "ssnNumber")
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        if let profile = aDecoder.decodeObject(forKey: "profile") as? String {
            self.profile   = profile
        }
        
        if let convertedDob = aDecoder.decodeObject(forKey: "convertedDob") as? String {
            self.convertedDob   = convertedDob
        }
        
        if let ssnNumber = aDecoder.decodeObject(forKey: "ssnNumber") as? String {
            self.ssnNumber   = ssnNumber
        }
        
        if let farmatedNumber = aDecoder.decodeObject(forKey: "farmatedNumber") as? String {
            self.farmatedNumber   = farmatedNumber
        }
        
        if let defaultProfileData = aDecoder.decodeObject(forKey: "defaultProfileData") as? DefaultProfileData {
            self.defaultProfileData   = defaultProfileData
        }
        
        if let dob = aDecoder.decodeObject(forKey: "dob") as? String {
            self.dob   = dob
        }
        
        if let city = aDecoder.decodeObject(forKey: "city") as? String {
            self.city   = city
        }
        
        if let state = aDecoder.decodeObject(forKey: "state") as? String {
            self.state   = state
        }
        
        if let zip_code = aDecoder.decodeObject(forKey: "zip_code") as? String {
            self.zip_code   = zip_code
        }
        
        if let address_id = aDecoder.decodeObject(forKey: "address_id") as? String {
            self.address_id   = address_id
        }
        
        
        if let password = aDecoder.decodeObject(forKey: "password") as? String {
            self.password   = password
        }
        
        
        if let privacy_policy = aDecoder.decodeObject(forKey: "privacy_policy") as? NSNumber {
            self.privacy_policy   = privacy_policy
        }
        
        if let terms_condition = aDecoder.decodeObject(forKey: "terms_condition") as? NSNumber {
            self.terms_condition   = terms_condition
        }
        
        if let lat = aDecoder.decodeObject(forKey: "lat") as? String {
            self.lat   = lat
        }
        
        if let lng = aDecoder.decodeObject(forKey: "lng") as? String {
            self.lng   = lng
        }
        
        
        if let userID = aDecoder.decodeObject(forKey: "userID") as? String {
            self.userID   = userID
        }
        
        if let userType = aDecoder.decodeObject(forKey: "userType") as? String {
            self.userType   = userType
        }
        
        if let firstname = aDecoder.decodeObject(forKey: "firstname") as? String {
            self.firstname   = firstname
        }
        
        if let middlename = aDecoder.decodeObject(forKey: "middlename") as? String {
            self.middlename   = middlename
        }
        
        if let lastname = aDecoder.decodeObject(forKey: "lastname") as? String {
            self.lastname   = lastname
        }
        
        if let email = aDecoder.decodeObject(forKey: "email") as? String {
            self.email   = email
        }
        
        if let gender = aDecoder.decodeObject(forKey: "gender") as? String {
            self.gender   = gender
        }
        
        if let country_code = aDecoder.decodeObject(forKey: "country_code") as? String {
            self.country_code   = country_code
        }
        
        if let phone_number = aDecoder.decodeObject(forKey: "phone_number") as? String {
            self.phone_number   = phone_number
        }
        
        if let specializationId = aDecoder.decodeObject(forKey: "specializationId") as? String {
            self.specializationId   = specializationId
        }
        
        if let categoryId = aDecoder.decodeObject(forKey: "categoryId") as? String {
            self.categoryId   = categoryId
        }
        
        if let experienceKey = aDecoder.decodeObject(forKey: "experienceKey") as? String {
            self.experienceKey   = experienceKey
        }
        
        if let address = aDecoder.decodeObject(forKey: "address") as? String {
            self.address   = address
        }
        
        if let isVerifyNumber = aDecoder.decodeObject(forKey: "isVerifyNumber") as? NSNumber {
            self.isVerifyNumber   = isVerifyNumber
        }
        
        if let isVerifyEmail = aDecoder.decodeObject(forKey: "isVerifyEmail") as? NSNumber {
            self.isVerifyEmail   = isVerifyEmail
        }
        
        if let categoryName = aDecoder.decodeObject(forKey: "categoryName") as? String {
            self.categoryName   = categoryName
        }
        
        if let specializationName = aDecoder.decodeObject(forKey: "specializationName") as? String {
            self.specializationName   = specializationName
        }
        
        if let experience = aDecoder.decodeObject(forKey: "experience") as? String {
            self.experience   = experience
        }
        
        if let address1 = aDecoder.decodeObject(forKey: "address1") as? String {
            self.address1   = address1
        }
        
        if let address2 = aDecoder.decodeObject(forKey: "address2") as? String {
            self.address2   = address2
        }
        
        if let orderType = aDecoder.decodeObject(forKey: "orderType") as? [String] {
            self.orderType   = orderType
        }
        
        if let preferences = aDecoder.decodeObject(forKey: "preferences") as? [String] {
            self.preferences   = preferences
        }
        
        if let default_profile_id = aDecoder.decodeObject(forKey: "default_profile_id") as? String {
            self.default_profile_id   = default_profile_id
        }
        
        if let age_group = aDecoder.decodeObject(forKey: "age_group") as? String {
            self.age_group   = age_group
        }
    }
}

//Defoult profile
class DefaultProfileData: NSObject, NSCoding{
    var userID                      = String()
    var firstname                   = String()
    var fullName                    = String()
    var lastname                    = String()
    var middlename                  = String()
    var relation                    = String()
    var userType                    = String()
    var defaultProfile              = Bool()
    var email                       = String()
    var password                    = String()
    var newPassword                 = String()
    var confirmPassword             = String()
    var gender                      = String()
    var dob                         = String()
    var country_code                = String()
    var phone_number                = String()
    var codeWithFlag                = String()
    var categoryId                  = String()
    var specializationId            = String()
    var profile                     = String()
    var orderType                   = [String]()
    var default_profile_id          = String()
    var age_group          = String()
    
    
    override init() {
        
    }
    
    init(_ dictionary: JSON){
        self.profile                   = dictionary["profile"].stringValue
        self.dob                       = dictionary["dob"].stringValue
        self.userType                      = dictionary["user_type"].stringValue
        self.relation                     = dictionary["relation"].stringValue
        self.defaultProfile                     = dictionary["default_profile"].boolValue
        
        for order in (dictionary["order_type"].arrayValue){
            self.orderType.append(order.stringValue)
        }
        
        self.userID                 = dictionary["_id"].stringValue
        self.firstname              = dictionary["firstname"].stringValue
        self.lastname               = dictionary["lastname"].stringValue
        self.middlename             = dictionary["middlename"].stringValue
        self.email                  = dictionary["email"].stringValue
        self.gender                 = dictionary["gender"].stringValue
        self.country_code           = dictionary["country_code"].stringValue
        self.phone_number           = dictionary["phone_number"].stringValue
        self.specializationId       = dictionary["specialization"].stringValue
        self.categoryId             = dictionary["category"].stringValue
        self.default_profile_id                = dictionary["default_profile_id"].stringValue
        
        self.age_group                = dictionary["age_group"].stringValue
    }
    
    //MARK: NSEncoding
    func encode(with coder: NSCoder) {
        coder.encode(self.profile , forKey: "profile")
        coder.encode(self.dob , forKey: "dob")
        coder.encode(self.password , forKey: "password")
        coder.encode(self.userID , forKey: "userID")
        coder.encode(self.firstname , forKey: "firstname")
        coder.encode(self.middlename , forKey: "middlename")
        coder.encode(self.lastname , forKey: "lastname")
        coder.encode(self.email , forKey: "email")
        coder.encode(self.gender , forKey: "gender")
        coder.encode(self.country_code , forKey: "country_code")
        coder.encode(self.phone_number , forKey: "phone_number")
        coder.encode(self.specializationId , forKey: "specializationId")
        coder.encode(self.categoryId , forKey: "categoryId")
        coder.encode(self.orderType , forKey: "orderType")
        coder.encode(self.default_profile_id , forKey: "default_profile_id")
        coder.encode(self.age_group , forKey: "age_group")
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        if let profile = aDecoder.decodeObject(forKey: "profile") as? String {
            self.profile   = profile
        }
        
        if let dob = aDecoder.decodeObject(forKey: "dob") as? String {
            self.dob   = dob
        }
        
        if let password = aDecoder.decodeObject(forKey: "password") as? String {
            self.password   = password
        }
        
        if let userID = aDecoder.decodeObject(forKey: "userID") as? String {
            self.userID   = userID
        }
        
        if let firstname = aDecoder.decodeObject(forKey: "firstname") as? String {
            self.firstname   = firstname
        }
        
        if let middlename = aDecoder.decodeObject(forKey: "middlename") as? String {
            self.middlename   = middlename
        }
        
        if let lastname = aDecoder.decodeObject(forKey: "lastname") as? String {
            self.lastname   = lastname
        }
        
        if let email = aDecoder.decodeObject(forKey: "email") as? String {
            self.email   = email
        }
        
        if let gender = aDecoder.decodeObject(forKey: "gender") as? String {
            self.gender   = gender
        }
        
        if let country_code = aDecoder.decodeObject(forKey: "country_code") as? String {
            self.country_code   = country_code
        }
        
        if let phone_number = aDecoder.decodeObject(forKey: "phone_number") as? String {
            self.phone_number   = phone_number
        }
        
        if let specializationId = aDecoder.decodeObject(forKey: "specializationId") as? String {
            self.specializationId   = specializationId
        }
        
        if let categoryId = aDecoder.decodeObject(forKey: "categoryId") as? String {
            self.categoryId   = categoryId
        }
        
        if let orderType = aDecoder.decodeObject(forKey: "orderType") as? [String] {
            self.orderType   = orderType
        }
        
        if let default_profile_id = aDecoder.decodeObject(forKey: "default_profile_id") as? String {
            self.default_profile_id   = default_profile_id
        }
        
        if let age_group = aDecoder.decodeObject(forKey: "age_group") as? String {
            self.age_group   = age_group
        }
    }
}

//devices model
class DevicesModel: NSObject, NSCoding{
    var type = String()
    var token = String()
    
    init(_ dictionary: JSON){
        type = dictionary["type"].stringValue
        token = dictionary["token"].stringValue
    }
    
    //MARK: NSEncoding
    func encode(with coder: NSCoder) {
        coder.encode(self.type , forKey: "type")
        coder.encode(self.token , forKey: "token")
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        if let type = aDecoder.decodeObject(forKey: "type") as? String {
            self.type   = type
        }
        
        if let token = aDecoder.decodeObject(forKey: "token") as? String {
            self.token   = token
        }
    }
}

//devices model
class PreferencesModel: NSObject, NSCoding{
    var all = NSNumber()
    var kids = NSNumber()
    var men = NSNumber()
    var women = NSNumber()
    var senior = NSNumber()
    var id = String()
    
    override init() {
        
    }
    init(_ dictionary: JSON){
        all = dictionary["all"].numberValue
        kids = dictionary["kids"].numberValue
        men = dictionary["men"].numberValue
        women = dictionary["women"].numberValue
        senior = dictionary["senior"].numberValue
        id = dictionary["_id"].stringValue
    }
    
    //MARK: NSEncoding
    func encode(with coder: NSCoder) {
        coder.encode(self.id , forKey: "id")
        coder.encode(self.men , forKey: "men")
        coder.encode(self.women , forKey: "women")
        coder.encode(self.kids , forKey: "kids")
        coder.encode(self.all , forKey: "all")
        coder.encode(self.senior , forKey: "senior")
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        if let id = aDecoder.decodeObject(forKey: "id") as? String {
            self.id   = id
        }
        
        if let men = aDecoder.decodeObject(forKey: "men") as? NSNumber {
            self.men   = men
        }
        
        if let women = aDecoder.decodeObject(forKey: "women") as? NSNumber {
            self.women   = women
        }
        
        if let kids = aDecoder.decodeObject(forKey: "kids") as? NSNumber {
            self.kids   = kids
        }

        if let all = aDecoder.decodeObject(forKey: "all") as? NSNumber {
            self.all   = all
        }
        
        if let senior = aDecoder.decodeObject(forKey: "senior") as? NSNumber {
            self.senior   = senior
        }
    }
}


//Address model
class AddressModel: NSObject{
    var id = String()
    var address = String()
    var addressType = String()
    var title = String()
    var lat = String()
    var lng = String()
    var active = Bool()
    var location = LocationModel()
    var city = String()
    
    override init() {
        
    }
    
    init(_ dictionary: JSON){
        id = dictionary["_id"].stringValue
        address = dictionary["address"].stringValue
        addressType = dictionary["address_type"].stringValue
        title = dictionary["title"].stringValue
        lat = dictionary["lat"].stringValue
        lng = dictionary["lng"].stringValue
        active = dictionary["active"].boolValue
        city  = dictionary["city"].stringValue
        
        if dictionary["location"].exists() {
            let prefer = dictionary["location"]
            self.location = LocationModel.init(prefer)
        }
    }
}

class LocationModel: NSObject{
    var type = String()
    var coordinates = [Double]()
    
    override init() {
        
    }
    
    init(_ dictionary: JSON){
        type = dictionary["type"].stringValue
        
        for order in (dictionary["coordinates"].arrayValue){
            self.coordinates.append(order.doubleValue)
        }
    }
}


//Category model
class CategoryListingModel: NSObject{
    var name = String()
    var categoryId = String()
    var categoryImage = String()
    var arrSubCategory = [SubCategoryListingModel]()
    
    override init() {
        
    }
    
    init(_ dictionary: JSON){
        name = dictionary["name"].stringValue
        categoryId = dictionary["_id"].stringValue
        categoryImage = dictionary["featured_image"].stringValue
        
        for objCat in (dictionary["sub_categories"].arrayValue){
            let subCat = SubCategoryListingModel.init(objCat)
            self.arrSubCategory.append(subCat)
        }
    }
}

//Sub Category model
class SubCategoryListingModel: NSObject{
    var name = String()
    var subCategoryId = String()
    
    override init() {
        
    }
    
    init(_ dictionary: JSON){
        name = dictionary["name"].stringValue
        subCategoryId = dictionary["_id"].stringValue
    }
}

//MARK: Stylist moel
class StylistModel: NSObject{
    
    var stylist_Id      = String()
    var status          = Int()
    var fName           = String()
    var lName           = String()
    var mName           = String()
    var experience      = String()
    var stylistImage    = String()
    
    override init() {
        
    }
    
    init(_ dictionary: JSON){
        stylist_Id              = dictionary["_id"].stringValue
        status                  = dictionary["online"].intValue
        fName                   = dictionary["firstname"].stringValue
        lName                   = dictionary["lastname"].stringValue
        mName                   = dictionary["middlename"].stringValue
        experience              = dictionary["experience"].stringValue
        stylistImage            = dictionary["profile"].stringValue
    }
}

