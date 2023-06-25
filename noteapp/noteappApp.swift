//
//  noteappApp.swift
//  noteapp
//
//  Created by Cordova  on 25/06/23.
//

import SwiftUI

@main
struct noteappApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
