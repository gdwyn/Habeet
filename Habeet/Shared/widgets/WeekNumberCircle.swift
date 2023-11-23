//
//  WeekNumberCircle.swift
//  Habeet
//
//  Created by Godwin IE on 12/11/2023.
//

import SwiftUI

struct WeekNumberCircle: View {
    var progress: CGFloat = 0.1
    var arcColor = Color.grayline

    var body: some View {
        ZStack {
            // Outer ring
            Circle()
                    .stroke(Color.gray.opacity(0.2), lineWidth: 2)
                    .frame(width: 38, height: 38)

            // Progress arc
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(arcColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                .frame(width: 38, height: 38)
                .rotationEffect(Angle(degrees: -90)) // Start from the top
                //.animation(.spring)

        }
    }
}

#Preview {
    WeekNumberCircle()
}
