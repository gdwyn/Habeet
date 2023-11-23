//
//  AddHabit.swift
//  Habeet
//
//  Created by Godwin IE on 21/11/2023.
//

import SwiftUI

struct AddHabit: View {
    @ObservedObject var habits : Habits

    @State private var title = ""
    @State private var habitIcon = ""
    @State private var frequency = ""
    @State private var selectedDays = [String]()
    
    let icons = ["💪", "🏋️‍♀️", "🚀", "⚡️", "👋", "🎉", "🙏", "✌️", "🔥", "🍔", "📖"]
    let days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack (spacing: 16) {
            HStack{
                Text("New Habit")
                    .font(.title.bold())
                Spacer()
                CustomButton(title: "Create", icon: "plus") {
                    
                    // create new habit
                    let habit = HabitItem(title: title, icon: habitIcon, frequency: frequency, isDone: false, days: selectedDays)
                    
                    // append created habit
                    habits.items.insert(habit, at: 0)
                    
                    //dismiss sheet after creating habit
                    dismiss()
                }
            }.padding()
            
            ScrollView{
                VStack (spacing: 34) {
                    TextField("Enter title", text: $title)
                        .font(.title)
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 18) {
                        Text("Icon")
                            .font(.callout)
                            .foregroundStyle(.gray)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack (spacing: 16) {
                                ForEach (icons, id: \.self) { icon in
                                    Button {
                                        habitIcon = icon
                                    } label: {
                                        Text(icon)
                                            .frame(width: 32, height: 32)
                                            .padding(18)
                                            .font(.title2)
                                            .background(habitIcon == icon ? .white : .grayline.opacity(0.6))
                                            .clipShape(Circle())
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    // MARK:  icons
                    
                    VStack(alignment: .leading, spacing: 18) {
                        HStack {
                            Text("Frequency")
                                .font(.callout)
                                .foregroundStyle(.gray)
                            
                            Spacer()
                            
                            Text(frequency)
                                .foregroundStyle(.white)
                                .font(.subheadline)
                        }
                        .padding(.horizontal)

                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack (spacing: 16) {
                                ForEach (days, id: \.self) { day in
                                    Button {
                                        // TODO: do somn
                                        if !selectedDays.contains(day) {
                                            selectedDays.append(day)
                                        } else if let index = selectedDays.firstIndex(of: day) {
                                            selectedDays.remove(at: index)
                                        }
                                        setFrequency()
                                        
                                    } label: {
                                        Text(day)
                                            .frame(width: 32, height: 32)
                                            .padding(18)
                                            .foregroundStyle(selectedDays.contains(day) ? .black : .gray)
                                            .font(.subheadline)
                                            .background(selectedDays.contains(day) ? .white : .grayline.opacity(0.6))
                                            .clipShape(Circle())
                                    }
                                    //.padding(.trailing, 8)
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                    }
                
                }
            }
            .frame(alignment: .top)
        }
    }
    
    func setFrequency() {
        if selectedDays.count == days.count {
            frequency = "Everyday"
        }
        
        else if selectedDays.contains(days[0])
        && selectedDays.contains(days[1])
        && selectedDays.contains(days[2])
        && selectedDays.contains(days[3])
        && selectedDays.contains(days[4])
        && !selectedDays.contains(days[5])
        && !selectedDays.contains(days[6])
        {
            frequency = "Weekdays"
            
        } else if selectedDays.contains("Sat") && selectedDays.contains("Sun") && !selectedDays.contains(where: { ["Mon", "Tue", "Wed", "Thu", "Fri"].contains($0) }) {
            frequency = "Weekends"
                
                
            } else {
                // Handle other cases as needed
                frequency = selectedDays.joined(separator: ", ")
            }
        }
    }


#Preview {
    AddHabit(habits: Habits())
}
