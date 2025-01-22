//
//  WebSocketManager.swift
//  ClientWebSocket
//
//  Created by Javier Calatrava on 22/1/25.
//

import Foundation

class WebSocketManager: ObservableObject {
    private var webSocketTask: URLSessionWebSocketTask?
    @Published var messages: [String] = []
    
    func connect() {
        let url = URL(string: "ws://localhost:8080")!
        webSocketTask = URLSession.shared.webSocketTask(with: url)
        webSocketTask?.resume()
        receiveMessage()
    }
    
    func send(_ message: String) {
        webSocketTask?.send(.string(message)) { error in
            if let error = error {
                print("Error sending message: \(error)")
            }
        }
    }
    
    private func receiveMessage() {
        webSocketTask?.receive { result in
            switch result {
            case .failure(let error):
                print("Error receiving message: \(error)")
            case .success(let message):
                switch message {
                case .string(let text):
                    DispatchQueue.main.async {
                        self.messages.append(text)
                    }
                default:
                    break
                }
                self.receiveMessage()
            }
        }
    }
}
