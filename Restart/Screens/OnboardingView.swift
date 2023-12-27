//
//  OnboardingView.swift
//  Restart
//
//  Created by Vito Borghi on 24/12/2023.
//

import SwiftUI

struct OnboardingView: View {
    
    @AppStorage("onboarding") var isOnboardingViewActive = true
    
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffset: CGFloat = 0
    
    @State private var isAnimating = false
    
    @State private var imageOffset: CGSize = .zero
    
    @State private var indicatorOpacity = 1.0
    
    @State private var textTitle = "Share."
    
    let hapticFeedback = UINotificationFeedbackGenerator()
    
    var body: some View {
        ZStack {
            Color.colorBlue
                .ignoresSafeArea(.all, edges: .all)
            
            VStack(spacing: 20) {
                Spacer()

                VStack(spacing: 0) {
                    //MARK: HEADER
                    
                    Text(textTitle)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundStyle(.white)
                        .transition(.opacity)
                        .id(textTitle)
                    
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
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : -40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                
                //MARK: BODY
                ZStack{
                    CircleGroupView(shapeColour: .white, shapeOpacity: 0.2)
                        .offset(x:imageOffset.width * -1)
                        .blur(radius: abs(imageOffset.width/5))
                        .animation(.easeOut(duration: 1), value: imageOffset)
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 0.5), value: isAnimating)
                        .offset(x:imageOffset.width * 1.2, y: 0)
                        .rotationEffect(.degrees(Double(imageOffset.width/20)))
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    if abs(imageOffset.width) <= 150 {
                                        imageOffset = gesture.translation
                                    }
                                    
                                    withAnimation(.linear(duration: 0.25)){
                                        indicatorOpacity = 0
                                        textTitle = "Give."
                                    }
                                }
                                .onEnded{ _ in
                                    imageOffset = .zero
                                    
                                    withAnimation(.linear(duration: 0.25)) {
                                        indicatorOpacity = 1
                                        textTitle = "Share."
                                    }
                                }
                        )
                        .animation(.easeOut(duration: 1), value: imageOffset)
                } //: Body
                .overlay(
                    Image(systemName: "arrow.left.and.right.circle")
                        .font(.system(size: 44, weight: .ultraLight))
                        .foregroundStyle(.white)
                        .offset(y: 20)
                        .opacity(isAnimating ? 1: 0)
                        .animation(.easeOut(duration: 1).delay(2), value: isAnimating)
                        .opacity(indicatorOpacity)
                    , alignment: .bottom
                )
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
                            .frame(width: buttonOffset + 80)
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
                        .offset(x: buttonOffset)
                        .gesture(
                            DragGesture()
                                .onChanged{ gesture in
                                    if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80 {
                                        buttonOffset = gesture.translation.width
                                    }
                                }
                                .onEnded{ _ in
                                    withAnimation(Animation.easeOut(duration: 0.4)) {
                                        if buttonOffset > buttonWidth/2 {
                                            hapticFeedback.notificationOccurred(.success)
                                            
                                            playSound("chimeup", type: "mp3")
                                            
                                            buttonOffset = buttonWidth - 80
                                            isOnboardingViewActive = false
                                        } else {
                                            hapticFeedback.notificationOccurred(.warning)
                                            buttonOffset = 0
                                        }
                                    }
                                }
                        )
                        
                        Spacer()
                    }//: HSTACK
                    
                } //: FOOTER
                .frame(width: buttonWidth, height: 80, alignment: .center)
                .padding()
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimating)
            } //: VStack
        } //: ZStack
        .onAppear {
            isAnimating = true
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    OnboardingView()
}
