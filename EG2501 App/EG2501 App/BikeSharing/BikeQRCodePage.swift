//
//  BikeQRCodePage.swift
//  EG2501 App
//
//  Created by Yi Long on 22/10/22.
//

import AVFoundation
import SwiftUI
import CodeScanner

struct BikeQRCodePage: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showSuccess: Bool = false
    @Binding var bikeID: String
    @Binding var bikeBatt: Int
    @Binding var pointsRewarded: Double
    @Binding var loanTime: Int
    @Binding var electric: Bool
    @Binding var twoWay: Bool
    @Binding var twoWayMaster: Bool
    @Binding var endAtShuttle: Bool
    
    @State private var scannedCode: String?
    
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
                
                Spacer()
            }
            .padding()
            
            Text("Scan the bike's QR Code to begin your trip!")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.horizontal)
            
            VStack {
                Text(originDock.name)
                    .font(.title2)
                    .frame(width: 380, height: 60)
                    .background(LinearGradient(colors: [.yellow, .orange], startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(10)
                
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
            
            CodeScannerView(codeTypes: [.qr]) { response in
                if case let .success(result) = response {
                    scannedCode = result.string
                }
            }
            .frame(width: 390, height: 390)
            .padding()
            
            HStack {
                Spacer()
                
                Button(action: {
                    showSuccess.toggle()
                }) {
                    Text("To view success page")
                        .frame(width: 300, height: 30, alignment: .trailing)
                }
                .padding()
                .fullScreenCover(isPresented: $showSuccess) {
                    BikeSuccessPage(bikeID: $bikeID, bikeBatt: $bikeBatt, pointsRewarded: $pointsRewarded, loanTime: $loanTime, twoWay: $twoWay, twoWayMaster: $twoWayMaster, electric: $electric, endAtShuttle: $endAtShuttle, originDock: self.originDock, destinationDock: self.destinationDock)
                }
            }
            
            Spacer()
        }
    }
}

struct BikeQRCodePage_Previews: PreviewProvider {
    static var previews: some View {
        BikeQRCodePage(bikeID: .constant("10000"), bikeBatt: .constant(100), pointsRewarded: .constant(1), loanTime: .constant(45), electric: .constant(true), twoWay: .constant(false), twoWayMaster: .constant(false), endAtShuttle: .constant(true), originDock: originDockTemplate, destinationDock: destinationDockTemplate)
    }
}
