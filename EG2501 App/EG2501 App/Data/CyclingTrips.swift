//
//  CyclingTrips.swift
//  EG2501 App
//
//  Created by Yi Long on 25/10/22.
//

import Foundation

class cyclingTrip {
    var twoWayMaster: Bool
    var twoWay: Bool
    var electric: Bool
    var endAtShuttle: Bool
    var chooseOrigin: Bool
    
    init(twoWayMaster: Bool, twoWay: Bool, electric: Bool, endAtShuttle: Bool, chooseOrigin: Bool) {
        self.twoWayMaster = twoWayMaster
        self.twoWay = twoWay
        self.electric = electric
        self.endAtShuttle = endAtShuttle
        self.chooseOrigin = chooseOrigin
    }
}
