//
//  WayFinderResult.swift
//  EG2501 App
//
//  Created by Yi Long on 22/10/22.
//

import SwiftUI

struct WayFinderResult: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showingAlert = false
    @State var backHome: Bool = false
    @State var showBike: Bool = false
    
    @ObservedObject var originLocation: location
    @ObservedObject var destinationLocation: location
    @ObservedObject var originBikeLocation: dock
    @ObservedObject var destinationBikeLocation: dock
    @ObservedObject var closestLRT: location
    @ObservedObject var closestBus: busStop
    
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
                .padding(.horizontal)
                
                Spacer()
            }
            
            HStack {
                Text("Here's what we could find.")
                    .font(.title)
                    .bold()
                    .padding()
                
                Button(action: {
                    showingAlert = true
                }) {
                    Image(systemName: "exclamationmark.circle.fill")
                        .foregroundColor(.purple)
                        .font(.system(size: 30))
                }
                .sheet(isPresented: $showingAlert) {
                    WayFinderResultHelpView()
                        .presentationDetents([.medium])
                }
            }
            
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "bicycle")
                        .font(.system(size: 20))
                        .foregroundColor(.mint)
                    
                    Text("Cycling")
                        .font(.title2)
                        .bold()
                }
                .padding(.horizontal)
                
                Text("Nearest Starting Bike Dock")
                    .font(.title3)
                    .fontWeight(.medium)
                    .underline()
                    .padding(.horizontal)
                
                Text("\(originBikeLocation.name)")
                    .font(.title2)
                    .frame(width: 380, height: 60)
                    .background(LinearGradient(colors: [.yellow, .orange], startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Text("Nearest Destination Bike Dock")
                    .font(.title3)
                    .fontWeight(.medium)
                    .underline()
                    .padding(.horizontal)
                
                Text("\(destinationBikeLocation.name)")
                    .font(.title2)
                    .frame(width: 380, height: 70)
                    .background(LinearGradient(colors: [.cyan, .mint], startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Text("ETA: 3 min")
                    .font(.title2)
                    .frame(width: 380, height: 70)
                    .background(LinearGradient(colors: [.green, .yellow], startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            .padding(.horizontal)
                
            Button(action: {
                showBike.toggle()
                originLocation.endWayFinder()
                destinationLocation.endWayFinder()
                originDockTemplate.copyDock(inDock: originBikeLocation)
                destinationDockTemplate.copyDock(inDock: destinationBikeLocation)
            }) {
                Text("Let's Cycle")
                    .font(.title)
                    .fontWeight(.regular)
                    .foregroundColor(Color.white)
                    .frame(width: 350, height: 40)
            }
            .fullScreenCover(isPresented: $showBike) {
                BikeSharingMain(originDock: originDockTemplate, destinationDock: destinationDockTemplate, fromWayFinder: true)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .padding(.horizontal)
                
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "bus.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.indigo)
                    
                    Text("Nearest Bus Stop")
                        .font(.title2)
                        .bold()
                }
                .padding(.horizontal)
                
                Text("\(closestBus.name)")
                    .font(.title2)
                    .frame(width: 380, height: 60)
                    .background(LinearGradient(colors: [.yellow, .orange], startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Text("ETA: 5 min")
                    .font(.title2)
                    .frame(width: 380, height: 70)
                    .background(LinearGradient(colors: [.cyan, .yellow], startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            .padding(.horizontal)
                
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "tram.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.cyan)
                    
                    Text("Nearest LRT Stop")
                        .font(.title2)
                        .bold()
                }
                .padding(.horizontal)
                
                Text("\(closestLRT.name)")
                    .font(.title2)
                    .frame(width: 380, height: 60)
                    .background(LinearGradient(colors: [.yellow, .orange], startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Text("ETA: 5 min")
                    .font(.title2)
                    .frame(width: 380, height: 70)
                    .background(LinearGradient(colors: [.cyan, .yellow], startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            .padding(.horizontal)
            
            Button(action: {
                backHome.toggle()
                originLocation.endWayFinder()
                destinationLocation.endWayFinder()
            }) {
                Text("Back Home")
                    .font(.title)
                    .fontWeight(.regular)
                    .foregroundColor(Color.white)
                    .frame(width: 390, height: 40)
            }
            .frame(width: 380, height: 70)
            .background(LinearGradient(colors: [.blue, .indigo], startPoint: .leading, endPoint: .trailing))
            .cornerRadius(10)
            .fullScreenCover(isPresented: $backHome, content: Home.init)
        }
    }
}

struct WayFinderResult_Previews: PreviewProvider {
    static var previews: some View {
        WayFinderResult(originLocation: originPureLocationTemplate, destinationLocation: destinationPureLocationTemplate, originBikeLocation: originDockTemplate, destinationBikeLocation: destinationDockTemplate, closestLRT: originPureLocationTemplate, closestBus: emptyBusStop)
    }
}
