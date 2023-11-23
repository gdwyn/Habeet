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
    
    @State private var displayedDay = ""
        
    var completedHabits: Int {
            habits.items.filter { $0.isDone }.count
        }
    
    var totalHabits: Int {
            habits.items.count
        }
    
    var filteredHabitsCount: Int {
        let filteredHabits = habits.items.filter { $0.days.contains(displayedDay) }
        return filteredHabits.count
    }

    var completedHabitsForDay: Int {
        habits.items.filter { $0.isDone && $0.days.contains(displayedDay) }.count
    }
        
    var body: some View {
        
        VStack (spacing: 34) {
            
            HStack {
                VStack (alignment: .leading, spacing: 8) {
                    
                    Text("🔥  \(completedHabits)")
                        .font(.title3.bold())
                    Text("Total habits completed")
                        .font(.subheadline)
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
                                
                                Button {
                                    withAnimation{
                                        displayedDay = weekDays.extractDate(date: day, format:"EEE")
                                    }
                                } label: {
                                    
                                VStack (spacing: 10) {
                                    Text(weekDays.extractDate(date: day, format: "EEE"))
                                        .font(.caption)
                                        .foregroundStyle((weekDays.extractDate(date: day, format: "dd")) == (weekDays.extractDate(date: Date(), format: "dd")) ? .white : .gray)
                                    
                                    ZStack {
                                        Text(weekDays.extractDate(date: day, format: "dd"))
                                            .font(.subheadline)
                                            .foregroundStyle((weekDays.extractDate(date: day, format: "EEE")) == displayedDay ? .white : .gray)
                                        
                                        if (weekDays.extractDate(date: day, format: "EEE")) == displayedDay {
                                            WeekNumberCircle(
                                                progress: CGFloat(progress),
                                                arcColor: (weekDays.extractDate(date: day, format: "EEE")) == displayedDay ? .white : .grayline)
                                        } else {
                                            Circle()
                                                    .stroke(Color.clear, lineWidth: 2)
                                                    .frame(width: 38, height: 38)
                                        }
                                        
                                    }
                                    .padding(.bottom, 2)
                                }
                                }
                            }
                        }
                    }
                    // week view
                    
                    CircleChart(progress: CGFloat(progress), progressText: "\(completedHabitsForDay)/\(filteredHabitsCount) habits")
                        .padding(.top, 40)

                }
                .padding(.bottom, 40)
                //week view and chart

                    Text("My habits")
                        .font(.title2.bold())
                        .listRowSeparator(.hidden)


            
            if habits.items.contains(where: { $0.days.contains(displayedDay) }) {
                ForEach(habits.items.indices, id: \.self) { index in
                    if habits.items[index].days.contains(displayedDay) {
                        HabitView(
                            title: habits.items[index].title,
                            frequency: habits.items[index].frequency,
                            icon: habits.items[index].icon,
                            isDone: $habits.items[index].isDone
                        ) {
                            // set progress
                            getProgress()

                            // store progress
                            UserDefaults.standard.set(progress, forKey: "progress")
                        }
                        .padding(.bottom, 1)
                    }
                }
                .onDelete(perform: removeHabitItem)
                .listRowSeparator(.hidden)
                
            } else {
                VStack(spacing: 12) {
                    Text("🪫")
                        .font(.largeTitle)
                    Text("No habit yet")
                        .foregroundColor(.gray)
                        .padding(.bottom, 1)
                        .listRowSeparator(.hidden)
                }
                .padding(.vertical, 90)
                .frame(maxWidth: .infinity)
                .background {
                    Color.gray.opacity(0.1)
                }
                .cornerRadius(18)
                .listRowSeparator(.hidden)


            }
            

           

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
                
                //set day
                displayedDay = weekDays.extractDate(date: Date(), format:"EEE")
            }
            .onChange(of: totalHabits) {
              getProgress()
            }
        
            .onChange(of: displayedDay) {
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
            if filteredHabitsCount == 0 {
                progress = 0.0
            } else {
                progress = Double(completedHabitsForDay) / Double(filteredHabitsCount)
                
            }
        }
    }

}


#Preview {
    Home()
}
