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
    
    var body: some View {
        ZStack{
            Circle()
                .stroke(shapeColour.opacity(shapeOpacity), lineWidth: 40)
                .frame(width: 260, height: 260, alignment: .center)
            Circle()
                .stroke(shapeColour.opacity((shapeOpacity)), lineWidth: 80)
                .frame(width: 260, height: 260, alignment: .center)
        } //: ZSTACK
    }
}

#Preview {
    ZStack {
        Color.colorBlue
            .ignoresSafeArea()
        CircleGroupView(shapeColour: .white, shapeOpacity: 0.2)
    }
}
