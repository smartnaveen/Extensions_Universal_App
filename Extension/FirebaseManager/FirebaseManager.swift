//
//  FirebaaseManager.swift
//  Firestore Demo
//
//  Created by Naveen Kumar on 10/10/21.
//
import UIKit
import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseCore
import SwiftyJSON
import FirebaseDatabase

class FirebaseManager: NSObject {
    static let shared = FirebaseManager()
    
    let storageRef = Storage.storage().reference()
    let storageRefFolder = Storage.storage().reference(withPath: "musics")
    // musics is folder name in storage
    
    let db = Firestore.firestore()
    let rdb = Database.database().reference()
    
    
    
    // MARK: - Get Data Direct From Storage
    func getData(completion: @escaping (_ music: String)->Void) {
        storageRefFolder.listAll { result, error in
            if let error = error {
                print(error.localizedDescription)
            }else {
                for item in result.items {
                    item.downloadURL { url, error in
                        if error != nil {
                            print(error?.localizedDescription ?? "")
                        }
                        if let safeURL = url?.absoluteString{
                            print(safeURL)
                            completion(safeURL)
                        }
                    }
                }
            }
        }
        
    }
    
    
    // MARK: - Save Data in Firestore
    func saveData(parameter: [String: Any], collectionName: String, completion: @escaping (_ status: Bool)->Void) {
        db.collection(collectionName).addDocument(data: parameter) { error in
            if error != nil {
                print(error?.localizedDescription ?? "")
                completion(false)
            }else {
                completion(true)
            }
        }
    }
    
    
    // MARK: - Save Image and Text in Firestore
    func setUsersPhotoURL(withImage: UIImage = UIImage.init(named: "Ambiet")!) {
        guard let imageData = withImage.jpegData(compressionQuality: 0.5) else { return }
        let storageRef = Storage.storage().reference().child("Test").child("Post2")
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        storageRef.putData(imageData, metadata: metaData) { (metadata, error) in
            guard let metadata = metadata else {
                print("error while uploading")
                return
            }
            
            storageRef.downloadURL { (url, error) in
                print(metadata.size) // Metadata contains file metadata such as size, content-type.
                storageRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        print("an error occured after uploading and then getting the URL")
                        return
                    }
                    
                    print(downloadURL)
                    let newDictionary = [
                        "first_name": "iPhone",
                        "id" : "1",
                        "last_name" : "XR",
                        "img_Url" : downloadURL.absoluteString
                    ] as [String : Any]
                    self.saveData(parameter: newDictionary, collectionName: "User") { status in
                        if status {
                            print("Save Successfully")
                        }
                    }
                    
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.photoURL = downloadURL
                    changeRequest?.commitChanges { (error) in
                        //handle error
                        
                    }
                }
            }
        }
    }
    
    
    // MARK: - Get Data From Firestore
    func getDataFromFirestore() {
        // User - Collection Name
        let db = Firestore.firestore()
        db.collection("User").getDocuments { (snapshot, error) in
            if error != nil {
                print(error ?? "")
            } else {
                for document in (snapshot?.documents)! {
                    let share = PostModel.init(obj: JSON(document.data()))
                    print(share.id)
                }
            }
        }
    }
    
    // delete, update
    // MARK: - Delete files & Folder from Storage
    func DeleteDataFromStorage()  {
        // Delete Files from Storage
        let childsImageURL = "https://firebasestorage.googleapis.com/v0/b/firestore-ffe86.appspot.com/o/Test%2FPost1?alt=media&token=d9b04358-3437-4b75-afc9-afd0815f2ac9"
        
        let storage = Storage.storage()
        let storageRef = storage.reference(forURL: childsImageURL)
  
        storageRef.delete { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("File deleted successfully")
            }
        }
        
        // Delete Folder from Storage
        // Storage Name - Test
        let storageRef1 = storage.reference().child("Test")
        storageRef1.listAll { result, error in
            if error != nil{
                print(error ?? "")
            }else {
                result.items.forEach { file in
                    file.delete { error in
                        if error != nil {
                            print(error ?? "")
                        }else {
                            print("File deleted successfully")
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Delete Firestore collection
    func deleteFirestore() {
        let db = Firestore.firestore()
        db.collection("User").getDocuments { (snapshot, error) in
            if error != nil {
                print(error ?? "")
            } else {
                for document in (snapshot?.documents)! {
                    document.reference.delete { error in
                        if error != nil{
                            print(error ?? "")
                        }else{
                            print("File deleted successfully")

                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Delete Firestore Document
    func deleteDocumentFromFirestore() {
        db.collection("User").document("qgCtramtN9BrI5mUeMm2").delete { err in
            if let err = err {
              print("Error removing document: \(err)")
            }
            else {
              print("Field successfully removed!")
            }
          }
    }
    
    // MARK: - Update Firestore Field
    func updateFirestore() {
        let db = Firestore.firestore()
        db.collection("User").getDocuments { (snapshot, error) in
            if error != nil {
                print(error ?? "")
            } else {
                for document in (snapshot?.documents)! {
                    document.reference.updateData(
                        [
                            "id" : 100,
                            "first_name" : "Macbook m1 Pro"
                        ]) { error in
                            if error != nil {
                                print(error ?? "")
                            }else {
                                print("sucessfully update field")
                            }
                    }
                }
            }
        }
        
    }
    
    
    
    // MARK: - RealTime DataBase
    // save simple text in realtime db
    func saveDataInRealTimeDatabase() {
        let rdb = Database.database().reference()
        let post = rdb.child("Posts").childByAutoId()
        let newDictionary = [
            "id": "10",
            "first_name": "Ramesh",
            "Last_name": "Kumar",
            "age": 21
        ] as [String : Any]
        post.setValue(newDictionary)
    }
    
    // Save Image with text in real time db
    func saveImageRealTimeDatabase() {
        let rdb = Database.database().reference()
        let post = rdb.child("Posts").childByAutoId()
        let newPostKey = post.key!

        let storageRef = Storage.storage().reference().child("images")
        let newImageRef = storageRef.child(newPostKey)

        let img = UIImage.init(named: "Ambiet")!
        guard let imageData = img.jpegData(compressionQuality: 0.75) else { return }
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        newImageRef.putData(imageData, metadata: metaData) { metaData, error in
            if error == nil, metaData != nil {
                newImageRef.downloadURL { url, error in
                    if error != nil {
                        print(error?.localizedDescription ?? "")
                    }
                    print(url?.absoluteString ?? "")
                    
                    let newDictionary = [
                        "id": "10",
                        "first_name" : "Bhole",
                        "last_name": "Baba",
                        "img_Url": url?.absoluteString ?? ""
                    ] as [String : Any]
                    post.setValue(newDictionary)
                }
            } else {
               print(error ?? "")
            }
        }
    }
    
    // Get Realtime data from db
    func getRealTimeData() {
        let db = Database.database().reference()
        db.child("Posts").observe(.childAdded) { (snapshot) in
            let snap = JSON(snapshot.value ?? "")
            let newPost = PostModel.init(obj: snap)
            print(newPost.id, newPost.firstName, newPost.imgURL)
        }
    }
    
    // Delete Nodes From RealTime DB
    func deleteChildFromRealTimeDB() {
        //        db.child("Posts").ref.removeValue()

        let db = Database.database().reference().child("Posts")
        db.child("-MmLOtq0nfJsRuAQq-iv").ref.removeValue { error, ref in
            if error != nil {
                print(error ?? "")
            }
            else {
                print("Delete sucessfull")
            }
        }
    }
    
    
    // update realTime db
    func updateRealTimeDB() {
        let ref = Database.database().reference()
        let id = "-MmLOtq0nfJsRuAQq-iv"
        ref.child("Posts").child("\(id)").updateChildValues(
            ["id": 10000,
             "first_name": "iPhone",
             "last_name": "XR"
            ])
    }
    
}
