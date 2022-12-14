//
//  WayFinderMain.swift
//  EG2501 App
//
//  Created by Yi Long on 22/10/22.
//

import SwiftUI
import MapKit

struct WayFinderMain: View {
    @State private var showDetail: Bool = false
    @State var chooseOrigin: Bool = true
    @State var showMap: Bool = false
    @State var startChosen: Bool = false
    @State var endChosen: Bool = false
    
    @StateObject var originLocation: location
    @StateObject var destinationLocation: location
    
    init(originLocation: location, destinationLocation: location) {
        _originLocation = StateObject(wrappedValue: originLocation)
        _destinationLocation = StateObject(wrappedValue: destinationLocation)
    }
    
    var body: some View {
        ScrollView {
            HStack {
                Image(systemName: "map.fill")
                    .font(.system(size: 45))
                    .foregroundColor(.orange)
                
                VStack(alignment: .leading) {
                    Text("WayFinder")
                        .font(.largeTitle)
                        .fontWeight(.black)
                    
                    Text("Tell us about your trip")
                        .font(.title)
                        .fontWeight(.semibold)
                }
                Spacer()
            }
            .padding([.top, .leading, .trailing, .bottom])
            
            HStack {
                Text("Starting Location")
                    .font(.title3)
                    .fontWeight(.medium)
                
                Spacer()
            }
            .padding(.horizontal)
            
            Button(action: {
                chooseOrigin = true
                showMap.toggle()
            }) {
                Text(originLocation.name == "" ? "View Map" : originLocation.name)
                    .font(.title)
                    .fontWeight(.regular)
                    .foregroundColor(.black)
                    .frame(width: 380, height: 50)
            }
            .fullScreenCover(isPresented: $showMap) {
                WayFinderMap(isOrigin: $chooseOrigin, originLocation: self.originLocation, destinationLocation: self.destinationLocation)
            }
            .background(LinearGradient(colors: [.yellow, .mint], startPoint: .leading, endPoint: .trailing))
            .cornerRadius(20)
            .controlSize(.large)
            .padding(.horizontal)
            
            HStack {
                Text("Destination Location")
                    .font(.title3)
                    .fontWeight(.medium)
                
                Spacer()
            }
            .padding(.horizontal)
            
            Button(action: {
                chooseOrigin = false
                showMap.toggle()
            }) {
                Text(destinationLocation.name == "" ? "View Map" : destinationLocation.name)
                    .font(.title)
                    .fontWeight(.regular)
                    .foregroundColor(.black)
                    .frame(width: 380, height: 50)
            }
            .fullScreenCover(isPresented: $showMap) {
                WayFinderMap(isOrigin: $chooseOrigin, originLocation: self.originLocation, destinationLocation: self.destinationLocation)
            }
            .background(LinearGradient(colors: [.yellow, .mint], startPoint: .leading, endPoint: .trailing))
            .cornerRadius(20)
            .controlSize(.large)
            .padding(.horizontal)
            
            Button(action: {
                if originLocation.name == "" {
                    originLocation.copyLocation(inLocation: coveLRT)
                }
                if destinationLocation.name == "" {
                    destinationLocation.copyLocation(inLocation: punggolMRT)
                }
                showDetail.toggle()
            }) {
                Text("Continue")
                    .font(.title2)
                    .fontWeight(.regular)
                    .foregroundColor(Color.white)
                    .frame(width: 350, height: 30)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .padding()
            .fullScreenCover(isPresented: $showDetail) {
                WayFinderResult(originLocation: self.originLocation, destinationLocation: self.destinationLocation, originBikeLocation: findClosestDock(inLocation: originLocation), destinationBikeLocation: findClosestDock(inLocation: destinationLocation), closestLRT: findClosestLRT(inLocation: originLocation), closestBus: findClosestBus(inLocation: originLocation))
            }
            
            Spacer()
        }
        .textFieldStyle(.roundedBorder)
    }
}

func findClosestDock(inLocation: location) -> dock {
    var res: dock = emptyDock
    var low: Double = 10000000
    let from = CLLocation(latitude: inLocation.coord.latitude, longitude: inLocation.coord.longitude)
    for d in bikeDocks {
        let to = CLLocation(latitude: d.coord.latitude, longitude: d.coord.longitude)
        if (from.distance(from: to) < low) {
            low = from.distance(from: to)
            res = d
        }
    }
    return res
}

func findClosestBus(inLocation: location) -> busStop {
    var res: busStop = emptyBusStop
    var low: Double = 10000000
    let from = CLLocation(latitude: inLocation.coord.latitude, longitude: inLocation.coord.longitude)
    for d in busStopsCore {
        let to = CLLocation(latitude: d.coord.latitude, longitude: d.coord.longitude)
        if (from.distance(from: to) < low) {
            low = from.distance(from: to)
            res = d
        }
    }
    return res
}

func findClosestLRT(inLocation: location) -> location {
    var res: location = originPureLocationTemplate
    var low: Double = 10000000
    let from = CLLocation(latitude: inLocation.coord.latitude, longitude: inLocation.coord.longitude)
    for d in locationsLRTCore {
        let to = CLLocation(latitude: d.coord.latitude, longitude: d.coord.longitude)
        if (from.distance(from: to) < low) {
            low = from.distance(from: to)
            res = d
        }
    }
    return res
}

struct WayFinderMain_Previews: PreviewProvider {
    static var previews: some View {
        WayFinderMain(originLocation: originPureLocationTemplate, destinationLocation: destinationPureLocationTemplate)
    }
}
