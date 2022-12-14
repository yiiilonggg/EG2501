//
//  InitialisePasses.swift
//  EG2501 App
//
//  Created by Yi Long on 23/10/22.
//

import Foundation

// normal passes
var oneTrip: Pass = Pass(id: UUID(), name: "One-Trip", description: "1 pass", price: 5)
var weeklyWanderer: Pass = Pass(id: UUID(), name: "Weekly Wanderer", description: "7 passes", price: 30)
var monthlyMover: Pass = Pass(id: UUID(), name: "Monthly Mover", description: "31 passes", price: 110)

// special passes
var couplePasses: Pass = Pass(id: UUID(), name: "Love at First Ride", description: "31 passes for you and your partner!", price: 210)


var normalPassesCore: [Pass] = [oneTrip, weeklyWanderer, monthlyMover]
var specialPassesCore: [Pass] = [couplePasses]
