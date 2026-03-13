//
//  SplashView.swift
//  GallagherDemo
//
//  Created by USER on 9/21/1447 AH.
//

import SwiftUI

struct SplashView: View {
    
    @Binding var showMainView: Bool
    @State private var offsetY: CGFloat = 0
    @State private var opacity: Double = 1.0
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            Text("Gallagher Demo")
                .font(.largeTitle)
                .fontWeight(.bold)
                .offset(y: offsetY)
                .opacity(opacity)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation(.easeInOut(duration: 1)) {
                    offsetY = -100
                    opacity = 0
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    showMainView = true
                }
            }
        }
    }
}
