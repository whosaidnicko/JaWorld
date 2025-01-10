//
//  JlieGm.swift
//  JaWorld
//
//  Created by Nicolae Chivriga on 10/01/2025.
//

import SwiftUI
import Lottie

struct JlieGm: View {
    var body: some View {
        ZStack {
            Image("bg")
                .resizable()
                .ignoresSafeArea()
            
            LottieView(animation: .named("jelleLoading"))
                .playing(loopMode: .loop)
                .resizable()
                .frame(width: 70, height: 80)
                
            WKWebViewRepresentable(url: URL(string: "https://plays.org/game/little-world-jellys/")!, onLoadCompletion: {
                
                
            })
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: BackButton())
    }
}
