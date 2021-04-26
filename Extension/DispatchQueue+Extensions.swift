//
//  DispatchQueue+Extensions.swift
//  Extension
//
//  Created by Mr. Naveen Kumar on 26/04/21.
//

import Foundation

typealias Dispatch = DispatchQueue

extension Dispatch {

    static func background(_ task: @escaping () -> ()) {
        Dispatch.global(qos: .background).async {
            task()
        }
    }

    static func main(_ task: @escaping () -> ()) {
        Dispatch.main.async {
            task()
        }
    }
    
}


//Usage :
/*
 Dispatch.background {
     // do stuff means contain logic

     Dispatch.main {
         // update UI
     }
 }

 ================================================================================
 
 Dispatch.background {
     self.giphyModel = giphyMod
     Dispatch.main {
         self.GiphyCollectionView.reloadData()
         SVProgressHUD.dismiss()
     }
 }
 
 */
