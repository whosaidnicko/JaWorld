//
//  BackButton.swift
//  JaWorld
//
//  Created by Nicolae Chivriga on 09/01/2025.
//


import SwiftUI

struct BackButton: View {
    @Environment(\.presentationMode) var mode
    var body: some View {
        Image("kamishek")
            .resizable()
            .frame(width: 30, height: 32)
            .onTapGesture {
                mode.wrappedValue.dismiss()
            }
    }
}
