//
//  HomeView.swift
//  Restart
//
//  Created by Vito Borghi on 24/12/2023.
//

import SwiftUI

struct HomeView: View {
    
    @AppStorage("onboarding") var isOnboardingViewActive = false
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            ZStack {
                CircleGroupView(shapeColour: .gray, shapeOpacity: 0.1)
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                    .padding()
            }
            
            Text("The time that leads to mastery is dependent on our focus.")
                .font(.title3)
                .fontWeight(.light)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
            
            Button {
                isOnboardingViewActive = true
            } label: {
                Image(systemName:"arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                
                Text("Restart")
                    .font(.title3)
                    .fontDesign(.rounded)
                    .fontWeight(.bold)
            }
            .buttonStyle(.borderedProminent)
            .clipShape(Capsule())
            .controlSize(.large)
        }
    }
}

#Preview {
    HomeView()
}
