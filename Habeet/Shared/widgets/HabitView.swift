//
//  HabitView.swift
//  Habeet
//
//  Created by Godwin IE on 19/11/2023.
//

import SwiftUI

struct HabitView: View {
    var title: String
    var frequency: String
    var icon: String
    
    @Binding var isDone: Bool

    var action: () -> Void

    var body: some View {
        HStack (spacing: 18) {
                ZStack {
                    Circle()
                        .frame(height: 54)
                        .foregroundStyle(.grayline.opacity(0.6))
                    
                    Text(icon)
                }
                
                VStack (alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline.bold())
                    HStack {
                        Image(systemName: "repeat")
                        
                        Text(frequency)
                            .font(.callout)
                    }
                    .foregroundStyle(.gray)
                    
                }
            
            
            Spacer()
          
            ZStack{
                Circle()
                    .frame(height: 40)
                    .foregroundStyle(isDone ? Color.green : Color.grayline)
                
                Image(systemName: "checkmark")
                    .foregroundStyle(isDone ? Color.white : Color.gray)
                    .imageScale(isDone ? .medium : .small)
            }
            .onTapGesture {
                withAnimation {
                       isDone.toggle()
                       action()
                   }
            }
            //Checkmark
            
            }
            .frame(maxWidth: .infinity)
            .padding(18)
            .overlay(
                RoundedRectangle(cornerRadius: 28)
                    .stroke(Color.grayline, lineWidth: 1)
            )
            
        }
    }


//#Preview {
//    HabitView(title: "Meditate", frequency: "Everyday", icon: "🙏", isDone: ) {}
//}
