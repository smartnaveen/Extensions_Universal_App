//
//  File.swift
//  iph
//
//  Created by Naveen Kumar on 06/08/21.
//

import Foundation
import SocketIO

class SocketHelper: NSObject {

    static let shared = SocketHelper()
    var socket: SocketIOClient?

    let manager = SocketManager(socketURL: URL(string: "http://52.1.212.217:5000")!, config: [.log(true), .compress])

     override init() {
       socket = manager.defaultSocket
    }

    func connectSocket(completion: @escaping(Bool) -> () ) {
        disconnectSocket()
        socket?.on(clientEvent: .connect) {[weak self] (data, ack) in
            print("socket connected")
            self?.socket?.removeAllHandlers()
            completion(true)
        }
      socket?.connect()
    }

    func disconnectSocket() {
        socket?.removeAllHandlers()
        socket?.disconnect()
        socket?.didError(reason: "err")
        print("socket Disconnected")
    }

    func checkConnection() -> Bool {
        if socket?.manager?.status == .connected {
            return true
        }
        return false

    }
    
    
    

    enum Events {

        case search

        var emitterName: String {
            return "get-order-status"
        }

        var listnerName: String {
            switch self {
            case .search:
                return "get-order-status"
            }
        }

        func emit(params: [String : Any]) {
            SocketHelper.shared.socket?.emit(emitterName, params)
        }

        func listen(completion: @escaping (Any) -> Void) {
            SocketHelper.shared.socket?.on(listnerName) { (response, emitter) in
                completion(response)
            }
        }

        func off() {
            SocketHelper.shared.socket?.off(listnerName)
        }
    }
}


// MARK: - How Can Used Socket.io in Project

/*
 
 override func viewDidLoad() {
     super.viewDidLoad()
     SocketHelper.shared.connectSocket { action in
         print("Connection sucessfully")
         
         var param = [String: Any]()
         param["order_id"] = "610bf7c70369f8a5e6d93e90"
         SocketHelper.Events.search.emit(params: param)
         
         
         SocketHelper.shared.socket?.on("get-order-status-610bf7c70369f8a5e6d93e90") { (response, emitter) in
              print(response[0])
             if let data = response[0] as? [String: Any] {
                 print(data["booking_status"])
             }

         }
         
         
     }
     
 }
 */
