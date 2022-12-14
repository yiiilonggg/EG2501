//
//  Categories.swift
//  EG2501 App
//
//  Created by Yi Long on 24/10/22.
//

import Foundation
import SwiftUI

class category: Identifiable, ObservableObject {
    var id: UUID
    var name: String
    var destination: AnyView
    var col: LinearGradient
    var icon: String
    var wordOffset: CGFloat
    
    init(id: UUID, name: String, destination: AnyView, col: LinearGradient, icon: String, wordOffset: CGFloat) {
        self.id = id
        self.name = name
        self.destination = destination
        self.col = col
        self.icon = icon
        self.wordOffset = wordOffset
    }
}
