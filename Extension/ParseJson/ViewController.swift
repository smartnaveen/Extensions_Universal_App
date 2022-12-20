//
//  ViewController.swift
//  ParseJson
//
//  Created by Mr. Naveen Kumar on 06/03/21.
//

import UIKit

/*

class ViewController: UIViewController {
    @IBOutlet weak var l1: UILabel!
    @IBOutlet weak var l2: UILabel!
    
    var result: UserBioData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parsejson()
    }
    
    func parsejson() {
        if let path = Bundle.main.path(forResource: "BioData", ofType: "json") {
            let url = URL(fileURLWithPath: path)
            do {
                let safeData =  try Data(contentsOf: url)
                let jsonDecorder = JSONDecoder()
                do {
                    let decode =  try jsonDecorder.decode(UserModel.self, from: safeData)
                    result = decode
                    let okData = result?.BioData
                    l1.text = okData?[0].FirstName
                    l2.text = okData?[0].LastName
                } catch  {
                    print("Errorrrr\(error)")
                }
                
            }catch {
                print("Error")
            }
            
        }
    }
}
 */
