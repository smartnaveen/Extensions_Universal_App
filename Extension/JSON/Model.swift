//
//  Model.swift
//  dem
//
//  Created by Naveen Kumar on 27/06/22.
//

import Foundation
import UIKit

// yes -> 1
// no -> 0
struct QuestionModel: Codable {
    var question: String = ""
    var value: String = ""
    
    func toJSON() -> [String:Any] {
        let json: [String: Any] = [
            "question": question,
            "value": value
        ]
        return json
    }
}


class ModelData: Codable {
    static let shared = ModelData()
    
    func getData() -> [QuestionModel] {
        let data: [QuestionModel] = [
            QuestionModel(question: "1", value: ""),
            QuestionModel(question: "2", value: ""),
            QuestionModel(question: "3", value: ""),
            QuestionModel(question: "4", value: ""),
            QuestionModel(question: "5", value: ""),
            QuestionModel(question: "6", value: ""),
            QuestionModel(question: "7", value: ""),
            QuestionModel(question: "8", value: ""),
            QuestionModel(question: "9", value: ""),
            QuestionModel(question: "10", value: ""),
            QuestionModel(question: "11", value: ""),
            QuestionModel(question: "12", value: "")
        ]
        return data
    }
}


protocol ObjectSavable {
    func setObject<Object>(_ object: Object, forKey: String) throws where Object: Encodable
    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable
}

extension UserDefaults: ObjectSavable {
    func setObject<Object>(_ object: Object, forKey: String) throws where Object: Encodable {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            set(data, forKey: forKey)
        } catch {
            throw ObjectSavableError.unableToEncode
        }
    }
    
    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable {
        guard let data = data(forKey: forKey) else { throw ObjectSavableError.noValue }
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(type, from: data)
            return object
        } catch {
            throw ObjectSavableError.unableToDecode
        }
    }
}

enum ObjectSavableError: String, LocalizedError {
    case unableToEncode = "Unable to encode object into data"
    case noValue = "No data object found for the given key"
    case unableToDecode = "Unable to decode object into given type"
    
    var errorDescription: String? {
        rawValue
    }
}
