//
//  GoingNavigate.swift
//  JaWorld
//
//  Created by Nicolae Chivriga on 09/01/2025.
//

import SwiftUI

struct GoingNavigate: View {
    @State var goToMenu: Bool = false
    @State var timerGoing: Timer?
    @State var percentage: Double = 0
    @State var rotationgEffect: Double = 0
    var body: some View {
        ZStack {
            Image("bg")
                .resizable()
                .ignoresSafeArea()
          
            NavigationLink("", destination: MenuView(), isActive: $goToMenu)
            
            VStack {
                Image("jaPlanetka")
                    .rotationEffect(.degrees(rotationgEffect))
                
                Text("\(String(Int(percentage))) %")
                    .font(.custom(Font.amarante, size: 25))
                    .foregroundColor(.white)
                
            }
            
                .onAppear() {
                    timerGoing = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                        if percentage < 100 {
                            percentage += 1
                            withAnimation {
                                rotationgEffect += 15                            }
                           
                        } else {
                            goToMenu = true 
                        }
                    }
                }
        
        }
    }
}



