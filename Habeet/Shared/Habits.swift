//
//  Habits.swift
//  Habeet
//
//  Created by Godwin IE on 20/11/2023.
//

import Foundation

class Habits : ObservableObject {
    
    @Published var items = [HabitItem]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "HabitItem")
            }
        }
    }
    
    init() {
        
        if let savedItems = UserDefaults.standard.data(forKey: "HabitItem") {
            if let decodedItems = try? JSONDecoder().decode([HabitItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
        

    }
}
