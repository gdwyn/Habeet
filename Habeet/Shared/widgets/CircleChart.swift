//
//  CircleChart.swift
//  Habeet
//
//  Created by Godwin IE on 22/11/2023.
//

import SwiftUI

struct CircleChart: View {
    var progress: CGFloat = 0.1
    var progressText = ""
    //var totalCount : CGFloat = 0.0
    ///var completedPercent = 0

    var body: some View {
        ZStack {
            // Outer ring
            Circle()
                    .stroke(Color.gray.opacity(0.2), lineWidth: 28)
                    .frame(width: 180, height: 180)

            // Progress arc
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(Gradient(colors: [Color.blue, Color.mainColor]), style: StrokeStyle(lineWidth: 28, lineCap: .round, lineJoin: .round))
                .frame(width: 180, height: 180)
                .rotationEffect(Angle(degrees: -90)) // Start from the top
                //.animation(.spring)


            // Percentage text
            VStack(spacing: 4) {
                Text("\(Int(progress * 100))%")
                    .font(.title3)
                    .fontWeight(.medium)
                
                Text(progressText)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
        }
    }
}

#Preview {
    CircleChart()
}
