//
//  Locations.swift
//  EG2501 App
//
//  Created by Yi Long on 24/10/22.
//

import Foundation
import MapKit

class location: Identifiable, ObservableObject {
    var id: UUID
    @Published var name: String
    var coord: CLLocationCoordinate2D
    
    init(id: UUID, name: String, coord: CLLocationCoordinate2D) {
        self.id = id
        self.name = name
        self.coord = coord
    }
    func copyLocation(inLocation: location) {
        self.id = inLocation.id
        self.name = inLocation.name
        self.coord = inLocation.coord
    }
    
    func endWayFinder() {
        self.name = ""
    }
}
