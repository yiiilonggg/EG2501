//
//  Passes.swift
//  EG2501 App
//
//  Created by Yi Long on 23/10/22.
//

import Foundation

struct Pass: Hashable, Codable, Identifiable {
    var id: UUID
    var name: String
    var description: String
    var price: Int
}
