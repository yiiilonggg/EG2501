//
//  InitialiseTrips.swift
//  EG2501 App
//
//  Created by Yi Long on 23/10/22.
//

import Foundation
import MapKit

var blankTrip: Trip = Trip(id: UUID(), name: "", frequency: "", seats: 0, startDate: "", time: "", pickUpLocation: "", additionalInfo: "", busId: "")

// monthly trips
var tampinesMonthly: Trip = Trip(id: UUID(), name: "To Tampines MRT Station", frequency: "Weekday AM", seats: 8, startDate: "01/11/2022", time: "", pickUpLocation: "", additionalInfo: "Monthly Bundle", busId: "PC1234C")
var woodlandsMonthly: Trip = Trip(id: UUID(), name: "To Woodlands MRT Station", frequency: "Weekday AM", seats: 7, startDate: "01/11/2022", time: "", pickUpLocation: "", additionalInfo: "Monthly Bundle", busId: "PC3346B")

// one time trip
var tampinesOneTrip: Trip = Trip(id: UUID(), name: "To Tampines MRT Station", frequency: "", seats: 1, startDate: "31/11/2022", time: "7AM", pickUpLocation: "", additionalInfo: "", busId: "PC1234C")
var woodlandsOneTrip: Trip = Trip(id: UUID(), name: "To Woodlands MRT Station", frequency: "", seats: 2, startDate: "31/11/2022", time: "7:30AM", pickUpLocation: "", additionalInfo: "", busId: "PC3346B")

// upcoming trips
var tampinesUpcoming: Trip = Trip(id: UUID(), name: "To Tampines MRT Station", frequency: "", seats: 2, startDate: "31/10/2022", time: "7AM", pickUpLocation: "Oasis Terrace", additionalInfo: "Monthly Bundle", busId: "PC1234C", coord: CLLocationCoordinate2D(latitude: 1.4024846332632224, longitude: 103.91264591189714))

// past trips
var oldRaffles: Trip = Trip(id: UUID(), name: "To Raffles City MRT Station", frequency: "", seats: 2, startDate: "30/10/2022", time: "6PM", pickUpLocation: "Oasis Terrace", additionalInfo: "One-Time Trip", busId: "PC7782C", coord: CLLocationCoordinate2D(latitude: 1.4024846332632224, longitude: 103.91264591189714))
var oldPunggola: Trip = Trip(id: UUID(), name: "To Punggol MRT Station", frequency: "", seats: 2, startDate: "28/10/2022", time: "6PM", pickUpLocation: "Tampines MRT Station", additionalInfo: "Monthly Bundle", busId: "PC1234C", coord: CLLocationCoordinate2D(latitude: 1.3547230127599565, longitude: 103.94282010420255))
var oldTampinesa: Trip = Trip(id: UUID(), name: "To Tampines MRT Station", frequency: "", seats: 2, startDate: "28/10/2022", time: "7AM", pickUpLocation: "Oasis Terrace", additionalInfo: "Monthly Bundle", busId: "PC1234C", coord: CLLocationCoordinate2D(latitude: 1.4024846332632224, longitude: 103.91264591189714))

var monthlyTripsCore = TripList(id: UUID(), initialList: [tampinesMonthly, woodlandsMonthly])
var oneTimeTripsCore = TripList(id: UUID(), initialList: [tampinesOneTrip, woodlandsOneTrip])
var pastTripsCore: [Trip] = [oldRaffles, oldPunggola, oldTampinesa]
var upcomingTripsCore = TripList(id: UUID(), initialList: [])
