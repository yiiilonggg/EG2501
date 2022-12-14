//
//  PurchasingTrip.swift
//  EG2501 App
//
//  Created by Yi Long on 25/10/22.
//

import SwiftUI
import MapKit

struct PurchasingTrip: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var trip: Trip
    var region: MKCoordinateRegion
    @State var boughtPass: Bool = false
    @State var pickUpLocation: String = ""
    @State var pickUpTime: String = "6AM"
    
    init(inPass: Trip) {
        _trip = StateObject(wrappedValue: inPass)
        self.region = MKCoordinateRegion(center: inPass.coord, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
    }
    var timings: [String] = ["6AM", "6:30AM", "7AM", "7:30AM", "8AM", "8:30AM", "9AM"]
    var seatsLeft: [String:Int] = ["6AM": 9, "6:30AM": 7, "7AM": 1, "7:30AM": 3, "8AM": 2, "8:30AM": 5, "9AM": 3]
    
    var body: some View {
        ScrollView {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Back")
                        .font(.headline )
                        .fontWeight(.regular)
                        .frame(width: 50, height: 10)
                }
                .padding()
                
                Spacer()
            }
            
            VStack(alignment: .leading) {
                HStack {
                    Text(trip.name)
                        .font(.title2)
                        .bold()
                    
                    Spacer()
                    
                    Text(trip.busId)
                }
                .padding(.top, 10)
                
                Text("Pick-Up Date and Time: \(trip.startDate)")
                
                Text("Pick-up Location: \(pickUpLocation)")
                
                Text("Additional Information: \(trip.additionalInfo)")
                    .padding(.bottom, 10)
            }
            .padding(.horizontal)
            .cornerRadius(10)
            
            Map(coordinateRegion: .constant(region), showsUserLocation: true, annotationItems: busStopsCore) { t in
                MapAnnotation(coordinate: t.coord) {
                    Image(systemName: "mappin")
                        .onTapGesture {
                            pickUpLocation = t.name
                        }
                        .foregroundColor(Color.red)
                        .font(.system(size: 30))
                }
            }
            .frame(width: 390, height: 390)
            
            HStack {
                VStack {
                    Text("Trip Cost")
                        .font(.title)
                    Text(String(trip.additionalInfo == "Monthly Bundle" ? 22 : 8))
                        .font(.largeTitle)
                        .bold()
                    Text("Passes")
                        .font(.headline)
                }
                .padding(.horizontal)
                .frame(width: 190, height: 120)
                .background(LinearGradient(colors: [.indigo, .cyan], startPoint: .leading, endPoint: .trailing))
                .cornerRadius(10)
                
                VStack {
                    Text("Passes Left")
                        .font(.title)
                    Text(String(profileTracker.passes))
                        .font(.largeTitle)
                        .bold()
                    Text("Passes")
                        .font(.headline)
                }
                .padding(.horizontal)
                .frame(width: 190, height: 120)
                .background(LinearGradient(colors: [.mint, .green], startPoint: .leading, endPoint: .trailing))
                .cornerRadius(10)
            }
            
            if (pickUpLocation != "") {
                VStack {
                    if boughtPass {
                        Text("Pass Bought!")
                            .font(.title2)
                            .bold()
                            .frame(width: 390, height: 60)
                            .foregroundColor(.white)
                            .background(!boughtPass ? .blue : .green)
                            .cornerRadius(10)
                    } else {
                        Picker("Selected pick-up time", selection: $pickUpTime) {
                            ForEach(timings, id: \.self) {
                                Text($0)
                            }
                            .font(.title2)
                            .bold()
                            .foregroundColor(.black)
                        }
                        .pickerStyle(.wheel)
                        .frame(width: 390, height: 60)
                        .background(LinearGradient(colors: [.indigo, .cyan, .green], startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(10)
                        
                        Text("\(seatsLeft[pickUpTime]!) Seats Left")
                            .font(.title2)
                            .bold()
                            .frame(width: 390, height: 60)
                            .background(LinearGradient(colors: [.indigo, .cyan, .green], startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        if !boughtPass {
                            boughtPass.toggle()
                            upcomingTripsCore.addTrip(inTrip: Trip(id: UUID(), name: trip.name, frequency: trip.frequency, seats: seatsLeft[pickUpTime]!, startDate: trip.startDate, time: pickUpTime, pickUpLocation: pickUpLocation, additionalInfo: trip.additionalInfo, busId: trip.busId))
                        } else {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }) {
                        Text(!boughtPass ? "Buy Pass!" : "Back")
                            .font(.title2)
                            .bold()
                            .frame(width: 390, height: 60)
                            .foregroundColor(.white)
                            .background(.blue)
                            .cornerRadius(10)
                    }
                    .controlSize(.large)
                }
            }
        }
        .background(getColor(trip: trip))
    }
}

func getColor(trip: Trip) -> LinearGradient {
    if trip.additionalInfo == "One-Time Trip" {
        return LinearGradient(colors: [.green, .mint], startPoint: .top, endPoint: .bottom)
    } else {
        return LinearGradient(colors: [.orange, .yellow], startPoint: .top, endPoint: .bottom)
    }
}

struct PurchasingTrip_Previews: PreviewProvider {
    static var previews: some View {
        PurchasingTrip(inPass: tampinesMonthly)
    }
}
