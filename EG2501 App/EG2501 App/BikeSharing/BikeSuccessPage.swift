//
//  BikeSuccessPage.swift
//  EG2501 App
//
//  Created by Yi Long on 22/10/22.
//

import SwiftUI
import MapKit

struct BikeSuccessPage: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showEnd: Bool = false
    @Binding var bikeID: String
    @Binding var bikeBatt: Int
    @Binding var pointsRewarded: Double
    @Binding var loanTime: Int
    @Binding var twoWay: Bool
    @Binding var twoWayMaster: Bool
    @Binding var electric: Bool
    @Binding var endAtShuttle: Bool
    
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
                .padding()
                
                Spacer()
            }
            
            HStack {
                Text("Your trip has started!")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Spacer()
            }
            .padding(.horizontal)
            
            VStack(alignment: .leading) {
                Text(destinationDock.name)
                    .font(.title2)
                    .frame(width: 380, height: 60)
                    .background(LinearGradient(colors: [.yellow, .orange], startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Text("ETA: 3 min")
                    .font(.title2)
                    .frame(width: 380, height: 70)
                    .background(LinearGradient(colors: [.cyan, .mint], startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            
            Map(coordinateRegion: .constant(MKCoordinateRegion(center: originDock.coord, span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025))), showsUserLocation: true, annotationItems: [originDock, destinationDock]) { annotation in
                MapAnnotation(coordinate: annotation.coord) {
                    Image(systemName: "mappin")
                        .foregroundColor(Color.red)
                        .font(.system(size: 30))
                }
            }
            .frame(width: 400, height: 500)
            
            Button(action: {
                showEnd.toggle()
            }) {
                Text("I've parked my bike!")
                    .font(.title2)
                    .fontWeight(.regular)
                    .foregroundColor(Color.white)
                    .frame(width: 300, height: 30)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .padding()
            .fullScreenCover(isPresented: $showEnd) {
                if (twoWay) {
                    BikeQRCodePage(bikeID: $bikeID, bikeBatt: $bikeBatt, pointsRewarded: $pointsRewarded, loanTime: $loanTime, electric: $electric, twoWay: .constant(false), twoWayMaster: $twoWayMaster, endAtShuttle: $endAtShuttle, originDock: self.destinationDock, destinationDock: self.originDock)
                } else {
                    BikeEndPage(bikeID: $bikeID, bikeBatt: $bikeBatt, pointsRewarded: $pointsRewarded, loanTime: $loanTime, twoWayMaster: $twoWayMaster, endAtShuttle: $endAtShuttle, originDock: self.originDock, destinationDock: self.destinationDock)
                }
            }
            
            Spacer()
        }
    }
}

struct BikeSuccessPage_Previews: PreviewProvider {
    static var previews: some View {
        BikeSuccessPage(bikeID: .constant("10000"), bikeBatt: .constant(100), pointsRewarded: .constant(1), loanTime: .constant(45), twoWay: .constant(false), twoWayMaster: .constant(false), electric: .constant(false), endAtShuttle: .constant(true), originDock: originDockTemplate, destinationDock: destinationDockTemplate)
    }
}
