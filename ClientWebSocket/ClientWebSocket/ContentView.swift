//
//  ContentView.swift
//  ClientWebSocket
//
//  Created by Javier Calatrava on 22/1/25.
//

import SwiftUI
import Combine


struct ContentView: View {
    @StateObject private var webSocketManager = WebSocketManager()
    @State private var messageText = ""
    
    var body: some View {
        VStack {
            List(webSocketManager.messages, id: \.self) { message in
                Text(message)
            }
            
            HStack {
                TextField("Enter message", text: $messageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Send") {
                    webSocketManager.send(messageText)
                    messageText = ""
                }
            }.padding()
        }
        .onAppear {
            webSocketManager.connect()
        }
    }
}

#Preview {
    ContentView()
}
