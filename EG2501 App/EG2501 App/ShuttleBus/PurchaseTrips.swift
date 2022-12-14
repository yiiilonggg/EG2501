//
//  PurchaseTrips.swift
//  EG2501 App
//
//  Created by Yi Long on 22/10/22.
//

import SwiftUI

struct PurchaseTrips: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showMonthly: Bool = false
    @State private var showOneTime: Bool = false
    @State private var showMoreTrips: Bool = false
    @State private var showBuying: Bool = false
    @State private var tripSelected: Trip = blankTrip
    var monthlyList: [Trip] = monthlyTripsCore.list
    var oneTimeList: [Trip] = oneTimeTripsCore.list
    
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
            
            HStack {
                Text("Where can we take you?")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Spacer()
            }
            .padding(.horizontal)
            
            HStack {
                Text("Monthly Passes")
                    .font(.title2)
                    .bold()
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 5)
            
            List(monthlyList) { trip in
                Button(action: {
                    showBuying.toggle()
                    tripSelected.copyTrip(inTrip: trip)
                }) {
                    VStack(alignment: .leading) {
                        Text(trip.name)
                            .bold()
                        Text("Frequency: " + String(trip.frequency))
                        Text("Number of Seats Remaining: " + String(trip.seats))
                        Text("Starts on: " + trip.startDate)
                    }
                }
                .listRowBackground(LinearGradient(colors: [.orange, .yellow], startPoint: .leading, endPoint: .trailing))
                .fullScreenCover(isPresented: $showBuying) {
                    PurchasingTrip(inPass: tripSelected)
                }
            }
            .listStyle(.plain)
            .cornerRadius(10)
            .frame(width: 390, height: CGFloat(monthlyList.count) * 110)
            .scrollDisabled(true)
            
            HStack {
                Spacer()
                
                Button(action: {
                    showMonthly.toggle()
                }) {
                    Text("View More")
                }
            }
            .padding(.horizontal)
            
            HStack {
                Text("One-Time Passes")
                    .font(.title2)
                    .bold()
                
                Spacer()
            }
            .padding(.horizontal)
            
            List(oneTimeList) { trip in
                VStack(alignment: .leading) {
                    Text(trip.name)
                        .bold()
                    Text("Date & Time: " + String(trip.startDate) + ", " + String(trip.time))
                    Text("Number of Seats Remaining: " + String(trip.seats))
                        .padding(.bottom, 5)
                }
                .listRowBackground(LinearGradient(colors: [.cyan, .mint], startPoint: .leading, endPoint: .trailing))
            }
            .listStyle(.plain)
            .cornerRadius(10)
            .frame(width: 390, height: CGFloat(oneTimeList.count) * 85)
            .scrollDisabled(true)
            
            HStack {
                Spacer()
                
                Button(action: {
                    showOneTime.toggle()
                }) {
                    Text("View More")
                }
            }
            .padding(.horizontal)
            
            Button(action: {
                showMoreTrips.toggle()
            }) {
                VStack {
                    Text("Don't see your trip? Click here to suggest routes!")
                    
                    Image(systemName: "exclamationmark.circle.fill")
                        .foregroundColor(.purple)
                        .font(.system(size: 30))
                }
            }
            .padding(.top)
            .sheet(isPresented: $showMoreTrips) {
                PurchaseTripsHelpView()
                    .presentationDetents([.medium])
            }
        }
    }
}

struct PurchaseTrips_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseTrips()
    }
}
