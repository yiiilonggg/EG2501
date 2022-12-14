//
//  IntiialiseCategories.swift
//  EG2501 App
//
//  Created by Yi Long on 24/10/22.
//

import Foundation
import SwiftUI

let bikeSharing: category = category(id: UUID(), name: "Bike Share", destination: AnyView(BikeSharingMain(originDock: originDockTemplate, destinationDock: destinationDockTemplate, fromWayFinder: false)), col: LinearGradient(colors: [.indigo, .mint], startPoint: .leading, endPoint: .trailing), icon: "bicycle", wordOffset: -70)
let shuttleBusCat: category = category(id: UUID(), name: "Shuttle Bus", destination: AnyView(ShuttleBusMain(fromBike: .constant(false), rewardEarned: .constant(false))), col: LinearGradient(colors: [.blue, .mint], startPoint: .leading, endPoint: .trailing), icon: "bus.fill", wordOffset: -60)
let rewards: category = category(id: UUID(), name: "Rewards", destination: AnyView(RewardsMain()), col: LinearGradient(colors: [.purple, .yellow], startPoint: .leading, endPoint: .trailing), icon: "gift", wordOffset: -80)
let wayFinder: category = category(id: UUID(), name: "WayFinder", destination: AnyView(WayFinderMain(originLocation: originPureLocationTemplate, destinationLocation: destinationPureLocationTemplate)), col: LinearGradient(colors: [.red, .orange], startPoint: .leading, endPoint: .trailing), icon: "map", wordOffset: -70)
let profile: category = category(id: UUID(), name: "Profile", destination: AnyView(ProfileMain()), col: LinearGradient(colors: [.black, .gray], startPoint: .leading, endPoint: .trailing), icon: "person.fill", wordOffset: -100)
let categoryCore: [category] = [bikeSharing, shuttleBusCat, rewards, wayFinder, profile]
