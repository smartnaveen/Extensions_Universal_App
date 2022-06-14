//
//  HomeViewController.swift
//  Extension
//
//  Created by Naveen Kumar on 10/07/21.
//

import UIKit
import Starscream
import SideMenu

class HomeViewController: UIViewController {
    
    var socket: WebSocket!
    var isConnected = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        var request = URLRequest(url: URL(string: "https://damp-beach-81446.herokuapp.com/")!)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        socket.delegate = self
        socket.connect()
        socket.write(string: "hello there!")
        
    }
    
    
    @IBAction func startSocketAction(_ sender: UIButton) {
        socket.write(string: "hello there!")
        
    }
    
    @IBAction func stopSocketAction(_ sender: UIButton) {
        if isConnected {
            sender.setTitle("Connect", for: .normal)
            socket.disconnect()
        } else {
            sender.setTitle("Disconnect", for: .normal)
            socket.connect()
        }
    }
    
}


extension HomeViewController: WebSocketDelegate {
    // MARK: - WebSocketDelegate
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .connected(let headers):
            isConnected = true
            print("websocket is connected: \(headers)")
        case .disconnected(let reason, let code):
            isConnected = false
            print("websocket is disconnected: \(reason) with code: \(code)")
        case .text(let string):
            print("Received text: \(string)")
        case .binary(let data):
            print("Received data: \(data.count)")
        case .ping(_):
            break
        case .pong(_):
            break
        case .viabilityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled:
            isConnected = false
        case .error(let error):
            isConnected = false
            handleError(error)
        }
    }
    
    func handleError(_ error: Error?) {
        if let e = error as? WSError {
            print("websocket encountered an error: \(e.message)")
        } else if let e = error {
            print("websocket encountered an error: \(e.localizedDescription)")
        } else {
            print("websocket encountered an error")
        }
    }
}
