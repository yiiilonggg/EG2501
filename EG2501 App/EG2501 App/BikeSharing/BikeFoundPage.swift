//
//  BikeFoundPage.swift
//  EG2501 App
//
//  Created by Yi Long on 22/10/22.
//

import SwiftUI

struct BikeFoundPage: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showingAlert = false
    @State private var showQR: Bool = false
    @State var bikeID: String = String(Int.random(in: 10000..<99999))
    @State var bikeBatt: Int = Int.random(in: 60..<100)
    @State var pointsRewarded: Double = Double.random(in: 0..<2)
    @State var loanTime: Int = 45
    @Binding var electric: Bool
    @Binding var twoWay: Bool
    @Binding var twoWayMaster: Bool
    @Binding var endAtShuttle: Bool
    
    @ObservedObject var originDock: dock
    @ObservedObject var destinationDock: dock
    
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
                Text("There is a bike for you!")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.bottom, 5)
                
                Button(action: {
                    showingAlert = true
                }) {
                    Image(systemName: "exclamationmark.circle.fill")
                        .foregroundColor(.purple)
                        .font(.system(size: 30))
                }
                .sheet(isPresented: $showingAlert) {
                    BikeFoundHelpView()
                        .presentationDetents([.medium])
                }
            }
            
            VStack(alignment: .leading) {
                Text("Bike Pick-Up Information")
                    .font(.title3)
                    .fontWeight(.medium)
                    .underline()
                    .padding(.horizontal)
                
                Text(originDock.name)
                    .font(.title2)
                    .frame(width: 380, height: 60)
                    .background(LinearGradient(colors: [.yellow, .orange], startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                HStack {
                    if electric {
                        HStack {
                            Text("Bike ID: \(bikeID)")
                                .font(.title2)
                                .frame(width: 230, height: 70)
                                .background(LinearGradient(colors: [.cyan, .mint], startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(10)
                            Text("\(bikeBatt)%   ")
                                .font(.title2)
                                .frame(width: 140, height: 70, alignment: .trailing)
                                .background(LinearGradient(colors: [.mint, .green], startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(10)
                                .overlay(
                                    Image(systemName: "battery.75")
                                        .offset(x: -25)
                                        .font(.system(size: 30))
                                )
                        }
                    } else {
                        Text("Bike ID: \(bikeID)")
                            .font(.title2)
                            .frame(width: 380, height: 70)
                            .background(LinearGradient(colors: [.cyan, .mint], startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
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
                
                Text("\(destinationDock.emptyRacks) docks available")
                    .font(.title2)
                    .frame(width: 380, height: 70)
                    .background(LinearGradient(colors: [.cyan, .mint], startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            
            VStack(alignment: .leading) {
                Text("Trip Information")
                    .font(.title3)
                    .fontWeight(.medium)
                    .underline()
                    .padding(.horizontal)
                
                Text("Max Loan Time: \(loanTime) min")
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
            
            Button(action: {
                showQR.toggle()
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
            .fullScreenCover(isPresented: $showQR) {
                BikeQRCodePage(bikeID: $bikeID, bikeBatt: $bikeBatt, pointsRewarded: $pointsRewarded, loanTime: $loanTime, electric: $electric, twoWay: $twoWay, twoWayMaster: $twoWayMaster, endAtShuttle: $endAtShuttle, originDock: self.originDock, destinationDock: self.destinationDock)
            }
        }
    }
}

struct BikeFoundPage_Previews: PreviewProvider {
    static var previews: some View {
        BikeFoundPage(electric: .constant(true), twoWay: .constant(false), twoWayMaster: .constant(false), endAtShuttle: .constant(true), originDock: originDockTemplate, destinationDock: destinationDockTemplate)
    }
}
