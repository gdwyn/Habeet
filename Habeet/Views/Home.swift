//
//  Home.swift
//  Habeet
//
//  Created by Godwin IE on 19/11/2023.
//

import SwiftUI

struct Home: View {
    @StateObject var habits = Habits()
    @StateObject var weekDays = WeekDays()

    @State private var showAddHabit = false
    
    var completedHabits: Int {
            habits.items.filter { $0.isDone }.count
        }
    
    var body: some View {
        VStack (spacing: 28) {
            
            HStack {
                VStack (alignment: .leading, spacing: 8) {
                    Text("Hey 👋 \(completedHabits)")
                        .font(.title2.bold())
                    Text("Let's build some good habits")
                        .font(.callout)
                        .foregroundStyle(.gray)
                }
                
                Spacer()
                
                CustomButton(title: "Add", icon: "plus") {
                    showAddHabit = true

                }
            }
            .padding(.horizontal, 20)
            // welcome text
            
            List {
                VStack {
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack (spacing: 10) {
                            ForEach(weekDays.currentWeek, id: \.self) { day in
                                
                                Text(day.formatted(date: .abbreviated, time: .omitted))
                            }
                        }
                    }
                    // week view
                    
                    Color.gray.opacity(0.3)
                        .frame(width: 180, height: 180)
                        .clipShape(Circle())
                        .padding(.top)
                    
                }

                Text("Today")
                    .font(.title2.bold())
                
                ForEach(habits.items.indices, id: \.self) { index in
                    HabitView(
                        title: habits.items[index].title,
                        frequency: habits.items[index].frequency,
                        icon: habits.items[index].icon,
                        isDone: $habits.items[index].isDone
                    ) {
                       // DO SOMETHING HERE
                        
                    }
                    .padding(.bottom, 0)
                    
                }
                .onDelete(perform: removeHabitItem)
                .listRowBackground(Color.clear)


            }
            .listStyle(.plain)
            .ignoresSafeArea()
            // scroll view
            
            
        }
        // parent vstack
            .sheet(isPresented: $showAddHabit) {
                AddHabit(habits: habits)
            }
    }
    
    func removeHabitItem (at offset : IndexSet) {
        habits.items.remove(atOffsets: offset)
    }
}


#Preview {
    Home(habits: Habits())
}
