//
//  HomeView.swift
//  Restart
//
//  Created by Vito Borghi on 24/12/2023.
//

import SwiftUI
import CoreMotion

struct HomeView: View {
    
    @AppStorage("onboarding") var isOnboardingViewActive = false
    @State private var isAnimating = false
    @State private var imageOffsetX: CGFloat = 0
    @State private var imageOffsetY: CGFloat = 0
    
    @State private var motionManager = CMMotionManager()
    @State private var motionX: Double = 0
    @State private var motionY: Double = 0
    
    func startMotion(){
            motionManager.startGyroUpdates(to: .main) { (data, _) in
                motionManager.gyroUpdateInterval = 0.001
                                
                imageOffsetY = CGFloat(-(data?.rotationRate.x ?? 0) * 25)
                imageOffsetX = CGFloat(-(data?.rotationRate.y ?? 0) * 25)
            }
    }
    
    func lowPassFilter(current: CMRotationRate, previous: CMRotationRate) -> CMRotationRate {
        let alpha = 0.95
        let x = alpha * previous.x + (1 - alpha) * current.x
        let y = alpha * previous.y + (1 - alpha) * current.y
        let z = alpha * previous.z + (1 - alpha) * current.z
        return CMRotationRate(x: x, y: y, z: z)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            ZStack {
                CircleGroupView(shapeColour: .gray, shapeOpacity: 0.1)
                    .offset(x: -imageOffsetX, y: -imageOffsetY)

                
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .offset(x: imageOffsetX,y: isAnimating ? 35 + imageOffsetY : -35 + imageOffsetY)
                    .animation(
                        Animation
                            .easeInOut(duration: 4)
                            .repeatForever()
                        , value: isAnimating
                    )
            }
            
            Text("The time that leads to mastery is dependent on our focus.")
                .font(.title3)
                .fontWeight(.light)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
            
            Button {
                withAnimation {
                    playSound("success", type: "m4a")
                    
                    motionManager.stopGyroUpdates()
                    isOnboardingViewActive = true
                }
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
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { isAnimating = true })
            
            guard motionManager.isGyroAvailable else { print("Gyro not available."); return }
            startMotion()
        }
    }
}

#Preview {
    HomeView()
}
