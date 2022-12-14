//
//  ViewPass.swift
//  EG2501 App
//
//  Created by Yi Long on 25/10/22.
//

import SwiftUI
import MapKit

struct ViewPass: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showingAlert: Bool = false
    @StateObject var trip: Trip
    var isOldTrip: Bool
    var region: MKCoordinateRegion
    
    init(inPass: Trip, oldTrip: Bool) {
        _trip = StateObject(wrappedValue: inPass)
        self.isOldTrip = oldTrip
        self.region = MKCoordinateRegion(center: inPass.coord, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
    }
    
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
            
            if !isOldTrip {
                Image(systemName: "wave.3.right.circle")
                    .font(.system(size: 200))
                    .foregroundColor(.indigo)
                
                HStack {
                    Text("Hold your device near the scanner when boarding!")
                        .font(.title)
                        .bold()
                        .padding(.horizontal)
                    
                    Button(action: {
                        showingAlert = true
                    }) {
                        Image(systemName: "exclamationmark.circle.fill")
                            .foregroundColor(.purple)
                            .font(.system(size: 30))
                    }
                    .sheet(isPresented: $showingAlert) {
                        ViewPassHelpView()
                            .presentationDetents([.medium])
                    }
                }
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
                
                Text("Pick-Up Date and Time: \(trip.startDate), \(trip.time)")
                
                Text("Pick-up Location: \(trip.pickUpLocation)")
                
                Text("Additional Information: \(trip.additionalInfo)")
                    .padding(.bottom, 10)
            }
            .padding(.horizontal)
            .cornerRadius(10)
            
            Map(coordinateRegion: .constant(region), showsUserLocation: true, annotationItems: [trip]) { t in
                MapAnnotation(coordinate: t.coord) {
                    Image(systemName: "mappin")
                        .foregroundColor(Color.red)
                        .font(.system(size: 30))
                }
            }
            .allowsHitTesting(false)
                .frame(width: 390, height: 390)
        }
        .background(getColor(trip: trip, isOld: isOldTrip))
    }
}

func getColor(trip: Trip, isOld: Bool) -> LinearGradient {
    if trip.additionalInfo == "One-Time Trip" {
        if isOld {
            return LinearGradient(colors: [.white, .gray, .mint], startPoint: .top, endPoint: .bottom)
        } else {
            return LinearGradient(colors: [.green, .mint], startPoint: .top, endPoint: .bottom)
        }
    } else {
        if isOld {
            return LinearGradient(colors: [.white, .gray, .yellow], startPoint: .top, endPoint: .bottom)
        } else {
            return LinearGradient(colors: [.orange, .yellow], startPoint: .top, endPoint: .bottom)
        }
    }
}

struct ViewPass_Previews: PreviewProvider {
    static var previews: some View {
        ViewPass(inPass: blankTrip, oldTrip: false)
    }
}
