//
//  APIConstant.swift
//  watch
//
//  Created by Mr. Naveen Kumar on 23/05/21.
//

import Foundation
import UIKit

class APIConstant: NSObject {

    static let baseUrl  = "https://busk2ztzsh.execute-api.us-east-1.amazonaws.com/api/"
    static let userAuth     = "userauth/"
    static let customer     = "customer/"
    static let finalBaseUrl = baseUrl + customer
    static let orderCustomer = baseUrl + "order-customer/"
    
    
    static func register() -> String{
        return baseUrl + userAuth + "customer-register"//"c-register"
    }
    
    static func login() -> String{
        return baseUrl + userAuth + "customer-login"//"c-login"
    }
    
    static func verify() -> String{
        return baseUrl + userAuth + "customer-verify-token"//"c-verify-token"
    }
    
    static func loginUsingPassword() -> String{
        return baseUrl + userAuth + "c-login-with-password"
    }
        
    static func updateProfileImage() -> String{
        return finalBaseUrl + "c-update-profile-image"//"c-update-profile-image"
    }
    
    static func updateProfile() -> String{
        return finalBaseUrl + "c-update-profile"//"c-update-profile"
    }
    
    static func listAllProfiles() -> String{
        return finalBaseUrl + "list-all-profiles"
    }
    
    static func makeProfileDefault() -> String{
        return finalBaseUrl + "make-profile-default"
    }
    
    static func addFamilyMember() -> String{
        return finalBaseUrl + "add-family-member"
    }
    
    static func updateFamilyMemberProfile() -> String{
        return finalBaseUrl + "update-family-member-profile"
    }
    
    static func deleteFamilyMemberProfile() -> String{
        return finalBaseUrl + "delete-family-member-profile"
    }
    
    static func listAddresses() -> String{
        return finalBaseUrl + "list-addresses"
    }
    
    static func addLocation() -> String{
        return finalBaseUrl + "add-location"
    }
    
    static func deleteAddress() -> String{
        return finalBaseUrl + "delete-address"
    }
    
    static func activateAddress() -> String{
        return finalBaseUrl + "activate-address"
    }
    
    static func categoryList() -> String{
        return finalBaseUrl + "category-list"
    }
    
    static func serviceList() -> String{
        return finalBaseUrl + "service-list"
    }
    
    static func searchStylist() -> String{
        return finalBaseUrl + "search-stylist"
    }
    
    static func showAllActiveStylist() -> String{
        return finalBaseUrl + "show-all-active-stylist"
    }

    static func stylistDetail() -> String{
        return finalBaseUrl + "stylist-detail"
    }
    
    static func setPreference() -> String{
        return finalBaseUrl + "set-preference"
    }
    
    //
    static func cartDetailApi() -> String{
        return baseUrl + "get-cart"
    }
    
    static func clearCart() -> String{
        return baseUrl + "clear-cart"
    }
    
    static func addServiceToCart() -> String{
        return orderCustomer + "add-service-to-cart"
    }
    
}

 // MARK:- How I Can Used
/*
 APIConstant.stylistDetail()
 */
