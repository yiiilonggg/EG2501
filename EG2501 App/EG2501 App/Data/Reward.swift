//
//  Reward.swift
//  EG2501 App
//
//  Created by Yi Long on 23/10/22.
//

import Foundation
import SwiftUI

struct Reward: Hashable, Codable, Identifiable {
    var id: UUID
    var name: String
    var points: Double
    var usedBy: String
    var redeemed: Bool
    var redeemedDate: String
    var imageName: String
}

struct RewardCategory: Identifiable {
    var id: UUID
    var name: String
    var col: LinearGradient
    var image: String
    var imageOffsetX: CGFloat
    var imageOffsetY: CGFloat
    var wordOffsetX: CGFloat
    var imageSize: CGFloat
}
