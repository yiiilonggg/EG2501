//
//  CyclingShuttleTracker.swift
//  EG2501 App
//
//  Created by Yi Long on 25/10/22.
//

import Foundation

class profileTracker: ObservableObject {
    static var name: String = "Eldson"
    static var count: Int = 9
    static var seen: Set<UUID> = Set()
    static var passes: Int = 31
    static var points: Double = 23
    
    static func addTrip(inTripID: UUID, inPoints: Double, isCycleShutte: Bool) -> Bool {
        if seen.contains(inTripID) {
            return false
        }
        
        if isCycleShutte {
            count += 1
            if count == 10 {
                count = 0
                passes += 1
                return true
            }
        }
        
        points += inPoints
        
        return false
    }
}
