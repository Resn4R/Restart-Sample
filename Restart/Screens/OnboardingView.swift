//
//  OnboardingView.swift
//  Restart
//
//  Created by Vito Borghi on 24/12/2023.
//

import SwiftUI

struct OnboardingView: View {
    
    @AppStorage("onboarding") var isOnboardingViewActive = true
    
    var body: some View {
        ZStack {
            Color.colorBlue
                .ignoresSafeArea(.all, edges: .all)
            
            VStack(spacing: 20) {
                Spacer()

                VStack(spacing: 0) {
                    //MARK: HEADER
                    
                    Text("Share.")
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundStyle(.white)
                    
                    Text("""
                    It's not how much we give but
                    how much love we put into giving.
                    """)
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10)
                    
                } //: HEADER
                //MARK: BODY
                ZStack{
                    ZStack{
                        Circle()
                            .stroke(.white.opacity(0.2), lineWidth: 40)
                            .frame(width: 260, height: 260, alignment: .center)
                        Circle()
                            .stroke(.white.opacity((0.2)), lineWidth: 80)
                            .frame(width: 260, height: 260, alignment: .center)
                    } //: ZSTACK
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                } //: Body
                
                Spacer()
                //MARK: FOOTER
                
                ZStack {
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
                    
                    Text("Get Started")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .offset(x: 20)
                    
                    HStack {
                        Capsule()
                            .fill(Color.colorRed)
                            .frame(width: 80)
                        Spacer()
                    }
                    
                   HStack {
                        ZStack {
                            Circle()
                                .fill(Color.colorRed)
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold))
                        }
                        .foregroundStyle(.white)
                        .frame(width: 80, height: 80, alignment: .center)
                        .onTapGesture {
                            isOnboardingViewActive = false
                        }
                        
                        Spacer()
                    }//: HSTACK
                    
                } //: FOOTER
                .frame(height: 80, alignment: .center)
                .padding()
            } //: VStack
        } //: ZStack
    }
}

#Preview {
    OnboardingView()
}