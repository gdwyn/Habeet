//
//  Home.swift
//  Habeet
//
//  Created by Godwin IE on 19/11/2023.
//

import SwiftUI

struct Home: View {
    @StateObject var habits = Habits()
    
    @State private var num = 0
    @State private var showAddHabit = false
    
    var body: some View {
        VStack (spacing: 28) {
            
            HStack {
                VStack (alignment: .leading, spacing: 8) {
                    Text("Hey 👋 \(num)")
                        .font(.title2.bold())
                    Text("Let's build some good habits")
                        .font(.callout)
                        .foregroundStyle(.gray)
                }
                
                Spacer()
                
                CustomButton(title: "Add", icon: "plus") {
                    withAnimation{
                        habits.items.append(HabitItem(title: "Gym", icon: "💪", frequency: "Everyday", isDone: false))
                        
                    }
                }
            }
            // welcome text
            
            ScrollView(showsIndicators: false) {
                Color.gray.opacity(0.3)
                    .frame(height: 65)
                
                Color.gray.opacity(0.3)
                    .frame(width: 180, height: 180)
                    .clipShape(Circle())
                    .padding(.top)
                
                VStack (alignment: .leading, spacing: 14) {
                    Text("Today")
                        .font(.title2.bold())
                    
                    ForEach(habits.items.indices, id: \.self) { index in
                        HabitView(
                            title: habits.items[index].title,
                            frequency: habits.items[index].frequency,
                            icon: habits.items[index].icon,
                            isDone: $habits.items[index].isDone
                        ) {
                            // Your action closure here
                            if habits.items[index].isDone {
                                num += 1
                            }
                        }
                        .padding(.bottom, 8)
                    }

                }
            }
            .ignoresSafeArea()
            // scroll view
            
            
        }
        // parent vstack
        .padding(.horizontal)
    }
}


#Preview {
    Home()
}
