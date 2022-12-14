//
//  BikeSharingMain.swift
//  EG2501 App
//
//  Created by Yi Long on 22/10/22.
//

import MapKit
import SwiftUI

struct BikeSharingMain: View {
    @State private var showResult: Bool = false
    @State private var showMap: Bool = false
    @State var fromWayFinder: Bool
    @State var backHome: Bool = false
    
    @State var twoWayMaster: Bool = false
    @State var twoWay: Bool = false
    @State var electric: Bool = false
    @State var endAtShuttle: Bool = false
    @State var chooseOrigin: Bool = true
    
    @StateObject var originLocation: dock
    @StateObject var destinationLocation: dock
    
    init(originDock: dock, destinationDock: dock, fromWayFinder: Bool) {
        _originLocation = StateObject(wrappedValue: originDock)
        _destinationLocation = StateObject(wrappedValue: destinationDock)
        _fromWayFinder = State(initialValue: fromWayFinder)
    }
    
    var body: some View {
        ScrollView {
            if fromWayFinder {
                HStack {
                    Button(action: {
                        backHome.toggle()
                    }) {
                        Text("Back Home")
                            .font(.headline )
                            .fontWeight(.regular)
                            .frame(width: 100, height: 10)
                    }
                    .fullScreenCover(isPresented: $backHome, content: Home.init)
                    .padding()
                    
                    Spacer()
                }
            }
            
            HStack {
                Image(systemName: "bicycle")
                    .font(.system(size: 45))
                    .foregroundColor(.indigo)
                VStack(alignment: .leading) {
                    Text("Bike Sharing")
                        .font(.largeTitle)
                        .fontWeight(.black)
                    
                    Text("Tell us about your trip")
                        .font(.title)
                        .fontWeight(.semibold)
                }
            }
            .padding([.top, .leading, .trailing])
            
            
            HStack {
                Text("Bike Pick-Up Dock")
                    .font(.title3)
                    .fontWeight(.medium)
                
                Spacer()
            }
            .padding([.top, .leading, .trailing])
            
            Button(action: {
                chooseOrigin = true
                showMap.toggle()
            }) {
                Text(originLocation.name == "" ? "View Map" : originLocation.name)
                    .font(.title)
                    .fontWeight(.regular)
                    .foregroundColor(.white)
                    .frame(width: 380, height: 50)
            }
            .fullScreenCover(isPresented: $showMap) {
                BikeMap(isOrigin: $chooseOrigin, originDock: originLocation, destinationDock: destinationLocation)
            }
            .background(LinearGradient(colors: [.blue, .mint], startPoint: .leading, endPoint: .trailing))
            .cornerRadius(20)
            .controlSize(.large)
            .padding(.horizontal)
            
            HStack {
                Text("Destination Dock")
                    .font(.title3)
                    .fontWeight(.medium)
                
                Spacer()
            }
            .padding([.top, .leading, .trailing])
            
            Button(action: {
                chooseOrigin = false
                showMap.toggle()
            }) {
                Text(destinationLocation.name == "" ? "View Map" : destinationLocation.name)
                    .font(.title)
                    .fontWeight(.regular)
                    .foregroundColor(.white)
                    .frame(width: 380, height: 50)
            }
            .fullScreenCover(isPresented: $showMap) {
                BikeMap(isOrigin: $chooseOrigin, originDock: originLocation, destinationDock: destinationLocation)
            }
            .background(LinearGradient(colors: [.blue, .mint], startPoint: .leading, endPoint: .trailing))
            .cornerRadius(20)
            .controlSize(.large)
            .padding(.horizontal)
            
            VStack {
                Toggle("Two-way Trip", isOn: $twoWay)
                    .font(.title3)
                    .fontWeight(.medium)
                    .padding([.top, .leading, .trailing])
                
                Toggle("Electric Bike", isOn: $electric)
                    .font(.title3)
                    .fontWeight(.medium)
                    .padding([.top, .leading, .trailing])
            }
            
            Button(action: {
                twoWayMaster = twoWay
                endAtShuttle = !twoWayMaster && checkIfEndAtShuttle(inDock: destinationLocation)
                showResult.toggle()
            }) {
                Text("I'm ready to cycle!")
                    .font(.title2)
                    .fontWeight(.regular)
                    .foregroundColor(Color.white)
                    .frame(width: 350, height: 30)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .padding()
            .fullScreenCover(isPresented: $showResult) {
                BikeFoundPage(electric: $electric, twoWay: $twoWay, twoWayMaster: $twoWayMaster, endAtShuttle: $endAtShuttle, originDock: originLocation, destinationDock: destinationLocation)
            }
            
            Spacer()
        }
        .textFieldStyle(.roundedBorder)
    }
}

func checkIfEndAtShuttle(inDock: dock) -> Bool {
    let from = CLLocation(latitude: inDock.coord.latitude, longitude: inDock.coord.longitude)
    for d in locationsLRTCore {
        let to = CLLocation(latitude: d.coord.latitude, longitude: d.coord.longitude)
        if (from.distance(from: to) < 300) {
            return true
        }
    }
    return false
}

struct BikeSharingMain_Previews: PreviewProvider {
    
    static var previews: some View {
        BikeSharingMain(originDock: originDockTemplate, destinationDock: destinationDockTemplate, fromWayFinder: false)
    }
}
