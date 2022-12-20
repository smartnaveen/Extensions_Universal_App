//
//  UserModel.swift
//  ParseJson
//
//  Created by Mr. Naveen Kumar on 06/03/21.
//

import Foundation

struct UserBioData: Decodable {
    let BioData: [BioData]
}
struct BioData: Decodable {
    let FirstName: String
    let LastName: String

}
