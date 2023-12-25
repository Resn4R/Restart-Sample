//
//  ContentView.swift
//  Restart
//
//  Created by Vito Borghi on 24/12/2023.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("onboarding") var isOnboardingViewActive = true
    
    var body: some View {
        ZStack {
            if isOnboardingViewActive { OnboardingView() } else { HomeView() }
        }
    }
}

#Preview {
    ContentView()
}
