//
//  MenuView.swift
//  JaWorld
//
//  Created by Nicolae Chivriga on 09/01/2025.
//

import SwiftUI

struct MenuView: View {
    @State var showRules: Bool = false
    var body: some View {
        ZStack {
            Image("bg")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Image("jaPlanetka")
                
                NavigationLink {
                    JlieGm()
                } label: {
                    Image("play")
                }

               
                
                HStack {
                    NavigationLink {
                        SettingsView()
                    } label: {
                        Image("settings")
                    }

                   
                    
                    Spacer()
                    
                    Button {
                        showRules = true
                    } label: {
                        Image("info")
                    }
                }
                .padding(.horizontal)
            }
            .disabled(showRules)
            
            if showRules {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .onTapGesture {
                        showRules = false
                    }
            }
            
            Image("rules")
                .offset(x: showRules ? 0 : -UIScreen.main.bounds.width)
                .animation(Animation.bouncy, value: showRules)
                .onTapGesture {
                    showRules = false
                }
        }
        .navigationBarBackButtonHidden()
    }
}
