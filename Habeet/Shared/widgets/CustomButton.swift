//
//  Button.swift
//  Habeet
//
//  Created by Godwin IE on 19/11/2023.
//

import SwiftUI

struct CustomButton: View {
    var title: String
    var icon: String
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.white)
                Text(title)
                    .font(.callout)
            }
            .foregroundColor(.white)
            .padding(.vertical, 14)
            .padding(.leading, 16)
            .padding(.trailing, 20)
            .background(Color.mainColor)
            .cornerRadius(100)
            
        }
    }
}

#Preview {
    CustomButton(title: "Add", icon: "plus") {}
}
