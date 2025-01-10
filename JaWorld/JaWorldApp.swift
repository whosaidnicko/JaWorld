//
//  JaWorldApp.swift
//  JaWorld
//
//  Created by Nicolae Chivriga on 09/01/2025.
//

import SwiftUI

@main
struct JaWorldApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                GoingNavigate()
            }
        }
    }
}

extension Font {
    static var amarante: String = "Amarante-Regular"
}
