//
//  BikeEndPage.swift
//  EG2501 App
//
//  Created by Yi Long on 22/10/22.
//

import SwiftUI

struct BikeEndPage: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var backHome: Bool = false
    @State private var toShuttle: Bool = false
    @State private var isRewarded: Bool = false
    @State var tripID: UUID = UUID()
    @Binding var bikeID: String
    @Binding var bikeBatt: Int
    @Binding var pointsRewarded: Double
    @Binding var loanTime: Int
    @Binding var twoWayMaster: Bool
    @Binding var endAtShuttle: Bool
    
    @ObservedObject var originDock: dock
    @ObservedObject var destinationDock: dock
    
    var body: some View {
        VStack {
            HStack {
                Text("Thank you for cycling with us!")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Spacer()
            }
            .padding([.horizontal, .bottom])
            
            VStack(alignment: .leading) {
                Text("Bike Pick-Up Information")
                    .font(.title3)
                    .fontWeight(.medium)
                    .underline()
                
                Text(originDock.name)
                    .font(.title2)
                    .frame(width: 380, height: 60)
                    .background(LinearGradient(colors: [.yellow, .orange], startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(10)
                
                Text("Bike ID: \(bikeID)")
                    .font(.title2)
                    .frame(width: 380, height: 70)
                    .background(LinearGradient(colors: [.cyan, .mint], startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(10)
            }
            
            VStack(alignment: .leading) {
                Text("Destination Information")
                    .font(.title3)
                    .fontWeight(.medium)
                    .underline()
                    .padding(.horizontal)
                
                Text(destinationDock.name)
                    .font(.title2)
                    .frame(width: 380, height: 60)
                    .background(LinearGradient(colors: [.yellow, .orange], startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            
            VStack(alignment: .leading) {
                Text("Trip Information")
                    .font(.title3)
                    .fontWeight(.medium)
                    .underline()
                    .padding(.horizontal)
                
                Text("\(twoWayMaster ? "Two-Way" : "One-Way") Trip")
                    .font(.title2)
                    .frame(width: 380, height: 60)
                    .background(LinearGradient(colors: [.yellow, .orange], startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Text("\(pointsRewarded, specifier: "%.2f") points awarded")
                    .font(.title2)
                    .frame(width: 380, height: 70)
                    .background(LinearGradient(colors: [.cyan, .mint], startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            
            if endAtShuttle {
                Button(action: {
                    isRewarded = profileTracker.addTrip(inTripID: tripID, inPoints: pointsRewarded, isCycleShutte: true)
                    toShuttle.toggle()
                    originDock.endtrip()
                    destinationDock.endtrip()
                }) {
                    Text("To Shuttle Bus!")
                        .font(.title2)
                        .bold()
                        .frame(width: 380, height: 60)
                        .foregroundColor(.black)
                        .background(LinearGradient(colors: [.purple, .yellow], startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(10)
                }
                .controlSize(.large)
                .fullScreenCover(isPresented: $toShuttle) {
                    ShuttleBusMain(fromBike: .constant(true), rewardEarned: $isRewarded)
                }
            }
            
            Button(action: {
                profileTracker.addTrip(inTripID: tripID, inPoints: pointsRewarded, isCycleShutte: false)
                backHome.toggle()
                originDock.endtrip()
                destinationDock.endtrip()
            }) {
                Text("Back Home")
                    .font(.title2)
                    .fontWeight(.regular)
                    .foregroundColor(Color.white)
                    .frame(width: 380, height: 60)
            }
            .background(LinearGradient(colors: [.blue, .cyan], startPoint: .leading, endPoint: .trailing))
            .cornerRadius(10)
            .controlSize(.large)
            .padding()
            .fullScreenCover(isPresented: $backHome, content: Home.init)
            
            Spacer()
        }
    }
}

struct BikeEndPage_Previews: PreviewProvider {
    static var previews: some View {
        BikeEndPage(bikeID: .constant("54645"), bikeBatt: .constant(100), pointsRewarded: .constant(1.68), loanTime: .constant(45), twoWayMaster: .constant(false), endAtShuttle: .constant(true), originDock: _BUS_STOP_65351, destinationDock: _PUNGGOL_MRT_A1)
    }
}
