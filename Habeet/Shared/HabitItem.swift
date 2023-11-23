//
//  HabitItem.swift
//  Habeet
//
//  Created by Godwin IE on 19/11/2023.
//

import Foundation

struct HabitItem: Identifiable, Codable {
    var id = UUID()
    let title: String
    let icon: String
    let frequency: String
    var isDone: Bool
    var days : [String]
    
}
