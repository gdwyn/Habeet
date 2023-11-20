//
//  ColorExtension.swift
//  Habeet
//
//  Created by Godwin IE on 19/11/2023.
//

import SwiftUI

extension ShapeStyle where Self == Color {
    static var darkBackground: Color {
        Color(red: 0.1, green: 0.1, blue: 0.2)
    }
    
    static var lightBackground: Color {
        Color(red: 0.2, green: 0.2, blue: 0.3)
    }
    
    static var grayline: Color {
        Color(hex: 0xff3D3D3D)
    }
    
    static var mainColor: Color {
        Color(hex: 0xff4C3EED)
    }
    
}
