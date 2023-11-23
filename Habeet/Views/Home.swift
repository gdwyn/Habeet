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
    
    @State private var progress = 0.0
    
    var completedHabits: Int {
            habits.items.filter { $0.isDone }.count
        }
    
    var totalHabits: Int {
            habits.items.count
        }
        
    var body: some View {
        VStack (spacing: 34) {
            
            HStack {
                VStack (alignment: .leading, spacing: 8) {
                    Text("Hey 👋 ")
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
                        HStack (spacing: 14) {
                            ForEach(weekDays.currentWeek, id: \.self) { day in
                                
                                VStack (spacing: 10) {
                                    Text(weekDays.extractDate(date: day, format: "EEE"))
                                        .font(.caption)
                                        .foregroundStyle((weekDays.extractDate(date: day, format: "dd")) == (weekDays.extractDate(date: Date(), format: "dd")) ? .white : .gray)
                                    
                                    ZStack {
                                        Text(weekDays.extractDate(date: day, format: "dd"))
                                            .font(.subheadline)
                                            .foregroundStyle((weekDays.extractDate(date: day, format: "dd")) == (weekDays.extractDate(date: Date(), format: "dd")) ? .white : .white.opacity(0.8))
                                        
                                        WeekNumberCircle(progress: progress, arcColor: 
                                                      
                                            (weekDays.extractDate(date: day, format: "dd")) == (weekDays.extractDate(date: Date(), format: "dd")) ? .white : .grayline
                                                         
                                        )
                                        
                                    }
                                    .padding(.bottom, 2)
                                }
                            }
                        }
                    }
                    // week view
                    
                    CircleChart(progress: CGFloat(progress), progressText: "\(completedHabits)/\(totalHabits) habits")
                        .padding(.top, 40)

                }
                .padding(.bottom, 40)
                //week view and chart

                    Text("My habits")
                        .font(.title2.bold())
                    
                    ForEach(habits.items.indices, id: \.self) { index in
                        HabitView(
                            title: habits.items[index].title,
                            frequency: habits.items[index].frequency,
                            icon: habits.items[index].icon,
                            isDone: $habits.items[index].isDone
                        ) {
                            // set progress
                            getProgress()
                            
                            //store progress
                            UserDefaults.standard.set(progress, forKey: "progress")
                        }
                        .padding(.bottom, 1)
                        
                    }
                    .onDelete(perform: removeHabitItem)
                    //.listRowBackground(Color.clear)
                
                // today habits vstack


            }
            //.listRowInsets(EdgeInsets())
            .listStyle(.plain)
            .ignoresSafeArea()
            .scrollIndicators(ScrollIndicatorVisibility.hidden)
                              
            // scroll view
            
            
        }
        // parent vstack
            .sheet(isPresented: $showAddHabit) {
                AddHabit(habits: habits)
            }
        
            .onAppear {
                // Retrieve progress from UserDefaults on view appear
                if let storedProgress = UserDefaults.standard.value(forKey: "progress") as? Double {
                    progress = storedProgress
                }
            }
            .onChange(of: totalHabits) {
              getProgress()
            }

    }
    
    func removeHabitItem (at offset : IndexSet) {
        withAnimation{
            habits.items.remove(atOffsets: offset)
        }
    }
    
    func getProgress() {
        withAnimation {
            if totalHabits == 0 {
                progress = 0.0
            } else {
                progress = Double(completedHabits) / Double(totalHabits)
            }
        }
    }

}


#Preview {
    Home()
}
