//
//  CircleGroupView.swift
//  Restart
//
//  Created by Vito Borghi on 25/12/2023.
//

import SwiftUI

struct CircleGroupView: View {
    @State var shapeColour: Color
    @State var shapeOpacity: Double
    @State private var isAnimating = false
    
    var body: some View {
        ZStack{
            Circle()
                .stroke(shapeColour.opacity(shapeOpacity), lineWidth: 40)
                .frame(width: 260, height: 260, alignment: .center)
            Circle()
                .stroke(shapeColour.opacity((shapeOpacity)), lineWidth: 80)
                .frame(width: 260, height: 260, alignment: .center)
        } //: ZSTACK
        .blur(radius: isAnimating ? 0 : 10)
        .opacity(isAnimating ? 1 : 0)
        .scaleEffect(isAnimating ? 1: 0.5)
        .animation(.easeOut(duration: 1), value: isAnimating)
        .onAppear{
            isAnimating = true
        }
    }
}

#Preview {
    ZStack {
        Color.colorBlue
            .ignoresSafeArea()
        CircleGroupView(shapeColour: .white, shapeOpacity: 0.2)
    }
}
