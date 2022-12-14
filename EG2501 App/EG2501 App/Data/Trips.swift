//
//  Trips.swift
//  EG2501 App
//
//  Created by Yi Long on 23/10/22.
//

import Foundation
import MapKit

class Trip: Identifiable, ObservableObject {
    var id: UUID
    var name: String
    var frequency: String
    var seats: Int
    var startDate: String
    var time: String
    var pickUpLocation: String
    var additionalInfo: String
    var busId: String
    var coord: CLLocationCoordinate2D
    
    init(id: UUID, name: String, frequency: String, seats: Int, startDate: String, time: String, pickUpLocation: String, additionalInfo: String, busId: String, coord: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 1.405264, longitude: 103.902097)) {
        self.id = id
        self.name = name
        self.frequency = frequency
        self.seats = seats
        self.startDate = startDate
        self.time = time
        self.pickUpLocation = pickUpLocation
        self.additionalInfo = additionalInfo
        self.busId = busId
        self.coord = coord
    }
    
    func copyTrip(inTrip: Trip) {
        self.id = inTrip.id
        self.name = inTrip.name
        self.frequency = inTrip.frequency
        self.seats = inTrip.seats
        self.startDate = inTrip.startDate
        self.time = inTrip.time
        self.pickUpLocation = inTrip.pickUpLocation
        self.additionalInfo = inTrip.additionalInfo
        self.busId = inTrip.busId
        self.coord = inTrip.coord
    }
}

class TripList: Identifiable, ObservableObject {
    var id: UUID
    @Published var list: [Trip]
    
    init(id: UUID, initialList: [Trip]) {
        self.id = id
        self.list = initialList
    }
    
    func addTrip(inTrip: Trip) {
        list.append(inTrip)
    }
    
    func removeTrip(inTrip: Trip) {
        var target = 0
        while target < list.count {
            if list[target].id == inTrip.id {
                break
            }
            target += 1
        }
        if target == list.count {
            return
        } else {
            list.remove(at: target)
        }
    }
}
