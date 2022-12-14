//
//  BusStops.swift
//  EG2501 App
//
//  Created by Yi Long on 24/10/22.
//

import Foundation
import MapKit

class busStop: location {
    var roadName: String
    var busStopCode: String
    
    init(id: UUID, name: String, coord: CLLocationCoordinate2D, roadName: String, busStopCode: String) {
        self.roadName = roadName
        self.busStopCode = busStopCode
        super.init(id: id, name: name, coord: coord)
    }
}
