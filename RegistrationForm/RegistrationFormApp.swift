//
//  RegistrationFormApp.swift
//  RegistrationForm
//
//  Created by Sudheshna Tholikonda on 11/07/25.
//

import SwiftUI

@main
struct RegistrationFormApp: App {
    init() {
           // Force light mode
           UIView.appearance().overrideUserInterfaceStyle = .light
       }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
