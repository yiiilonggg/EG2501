//
//  BikeMap.swift
//  EG2501 App
//
//  Created by Yi Long on 22/10/22.
//

import SwiftUI
import MapKit

struct BikeMap: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showingAlert = false
    @State private var showEnd: Bool = false
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 1.405264, longitude: 103.902097), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
    
    @State var bikes: Int = 0
    @State var docks: Int = 0
    var annotations: [dock] = bikeDocks
    @Binding var isOrigin: Bool
    @ObservedObject var originDock: dock
    @ObservedObject var destinationDock: dock
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Back")
                        .font(.headline )
                        .fontWeight(.regular)
                        .frame(width: 50, height: 10)
                }
                Spacer()
            }
            .padding()
            
            HStack {
                Text("Bike Sharing Map")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                
                Button(action: {
                    showingAlert = true
                }) {
                    Image(systemName: "exclamationmark.circle.fill")
                        .foregroundColor(.purple)
                        .font(.system(size: 30))
                }
                .sheet(isPresented: $showingAlert) {
                    BikeSharingMapHelpView()
                        .presentationDetents([.medium])
                }
            }
            
            // include userTrackingMode: .constant(.follow) foer centre around user
            Map(coordinateRegion: .constant(region), showsUserLocation: true, annotationItems: annotations) { annotation in
                MapAnnotation(coordinate: annotation.coord) {
                    Image(systemName: "mappin")
                        .onTapGesture {
                            region = MKCoordinateRegion(center: annotation.coord, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
                            if (isOrigin) {
                                originDock.copyDock(inDock: annotation)
                                bikes = originDock.bikeCount
                                docks = originDock.emptyRacks
                            } else {
                                destinationDock.copyDock(inDock: annotation)
                                bikes = destinationDock.bikeCount
                                docks = destinationDock.emptyRacks
                            }
                        }
                        .foregroundColor(Color.red)
                        .font(.system(size: 30))
                }
            }
            VStack {
                Text("Bike Dock Information")
                    .font(.title3)
                    .fontWeight(.medium)
                    .underline()
                    .padding(.horizontal)
                
                Text(isOrigin ? originDock.name : destinationDock.name)
                    .font(.title2)
                    .frame(width: 380, height: 50)
                    .background(LinearGradient(colors: [.yellow, .orange], startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(10)
                
                HStack {
                    Text(bikes == 0 ? "NA" : "\(bikes)\nbikes")
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .frame(width: 185, height: 70)
                        .background(LinearGradient(colors: [.cyan, .mint], startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(10)
                    Text(docks == 0 ? "NA" : "\(docks)\ndocks")
                        .multilineTextAlignment(.center)
                        .font(.title2)
                        .frame(width: 185, height: 70)
                        .background(LinearGradient(colors: [.mint, .green], startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            }
            
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
    }
}

struct BikeMap_Previews: PreviewProvider {
    static var previews: some View {
        BikeMap(isOrigin: .constant(true), originDock: _PUNGGOL_MRT_A1, destinationDock: destinationDockTemplate)
    }
}
