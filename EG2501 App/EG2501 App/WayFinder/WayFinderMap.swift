//
//  BikeMap.swift
//  EG2501 App
//
//  Created by Yi Long on 22/10/22.
//

import SwiftUI
import MapKit

struct WayFinderMap: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showEnd: Bool = false
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 1.405264, longitude: 103.902097), span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025))
    
    var annotations: [location] = locationsCore
    @Binding var isOrigin: Bool
    @ObservedObject var originLocation: location
    @ObservedObject var destinationLocation: location
    
    var body: some View {
        VStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Back")
                    .font(.headline )
                    .fontWeight(.regular)
                    .frame(width: 50, height: 10)
            }
            .offset(x: -170)
            .padding()
            
            Text("WayFinder Map")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.horizontal, 20)
            
            // include userTrackingMode: .constant(.follow) foer centre around user
            Map(coordinateRegion: .constant(region), showsUserLocation: true, annotationItems: annotations) { annotation in
                MapAnnotation(coordinate: annotation.coord) {
                    Image(systemName: "mappin")
                        .onTapGesture {
                            region = MKCoordinateRegion(center: annotation.coord, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
                            print(isOrigin)
                            if (isOrigin) {
                                originLocation.copyLocation(inLocation: annotation)
                            } else {
                                destinationLocation.copyLocation(inLocation: annotation)
                            }
                        }
                        .foregroundColor(Color.red)
                        .font(.system(size: 30))
                }
            }
            VStack(alignment: .leading) {
                Text("Location Information")
                    .font(.title3)
                    .fontWeight(.medium)
                    .underline()
                    .padding(.horizontal)
                
                Text(isOrigin ? originLocation.name : destinationLocation.name)
                    .frame(width: 400, height: 30)
                    .border(.gray)
                    .padding(.horizontal)
            }
            .padding(.horizontal)
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Select")
                    .font(.title2)
                    .fontWeight(.regular)
                    .foregroundColor(Color.white)
                    .frame(width: 350, height: 30)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .padding()
        }
        .padding(.horizontal)
    }
}

struct WayFinderMap_Previews: PreviewProvider {
    static var previews: some View {
        WayFinderMap(isOrigin: .constant(true), originLocation: originPureLocationTemplate, destinationLocation: destinationPureLocationTemplate)
    }
}
