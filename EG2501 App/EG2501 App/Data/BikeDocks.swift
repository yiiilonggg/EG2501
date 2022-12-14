//
//  BikeDocks.swift
//  EG2501 App
//
//  Created by Yi Long on 23/10/22.
//

import Foundation
import MapKit

class dock : location {
    var rackType: String
    var rackCount: Int
    var shelter: Bool
    var bikeCount: Int
    var emptyRacks: Int
    
    init(id: UUID, name: String, coord: CLLocationCoordinate2D, rackType: String, rackCount: Int, shelter: Bool, bikeCount: Int, emptyRacks: Int) {
        self.rackType = rackType
        self.rackCount = rackCount
        self.shelter = shelter
        self.bikeCount = bikeCount
        self.emptyRacks = emptyRacks
        super.init(id: id, name: name, coord: coord)
    }
    
    func copyDock(inDock: dock) {
        self.id = inDock.id
        self.name = inDock.name
        self.coord = inDock.coord
        self.rackType = inDock.rackType
        self.rackCount = inDock.rackCount
        self.shelter = inDock.shelter
        self.bikeCount = inDock.bikeCount
        self.emptyRacks = inDock.emptyRacks
    }
    
    func endtrip() {
        self.name = ""
        self.rackType = ""
        self.rackCount = 0
        self.shelter = false
        self.bikeCount = 0
        self.emptyRacks = 0
    }
}
