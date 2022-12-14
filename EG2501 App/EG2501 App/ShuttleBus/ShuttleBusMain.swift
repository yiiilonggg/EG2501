//
//  ShuttleBusMain.swift
//  EG2501 App
//
//  Created by Yi Long on 22/10/22.
//

import SwiftUI

struct ShuttleBusMain: View {
    @State private var showPurchaseTrips: Bool = false
    @State private var showPurchasePasses: Bool = false
    @Binding var fromBike: Bool
    @Binding var rewardEarned: Bool
    @State var backHome: Bool = false
    
    var body: some View {
        ScrollView {
            if fromBike {
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
                
                HStack {
                    Image(systemName: "bus.fill")
                        .font(.system(size: 45))
                        .foregroundColor(.mint)
                    
                    VStack (alignment: .leading) {
                        Text("Shuttle Bus")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("We hope you had a great cycle!")
                            .font(.title2)
                    }
                    Spacer()
                }
                .padding([.horizontal, .bottom])
                
                if rewardEarned {
                    Text("Congratulations! You have earned 1 PassBack for completing our Cycle-to-Shuttle reward program!")
                        .padding(10)
                        .border(AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center, startAngle: .zero, endAngle: .degrees(360)), width: 5)
                        .font(.headline)
                }
                
            } else {
                HStack {
                    Image(systemName: "bus.fill")
                        .font(.system(size: 45))
                        .foregroundColor(.mint)
                    
                    Text("Shuttle Bus")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .offset(y: 10)
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
            
            RegisteredPassView()
            
            HStack {
                Text("Account Information")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 5)
            
            VStack {
                Text(String(profileTracker.passes))
                    .font(.largeTitle)
                    .bold()
                Text("Passes")
                    .font(.headline)
            }
            .padding(.horizontal)
            .frame(width: 390, height: 100)
            .background(LinearGradient(colors: [.mint, .green], startPoint: .leading, endPoint: .trailing))
            .cornerRadius(10)
            
            HStack {
                Button(action: {
                    showPurchasePasses.toggle()
                }) {
                    Text("Purchase Passes")
                        .font(.headline)
                        .frame(width: 180, height: 50)
                        .foregroundColor(.black)
                        .background(LinearGradient(colors: [.purple, .yellow], startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(10)
                }
                .fullScreenCover(isPresented: $showPurchasePasses, content: PurchasePasses.init)
                
                Spacer()
                
                Button(action: {
                    showPurchaseTrips.toggle()
                }) {
                    Text("Purchase Trips")
                        .frame(width: 180, height: 50)
                        .foregroundColor(.black)
                        .background(LinearGradient(colors: [.cyan, .blue], startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(10)
                }
                .fullScreenCover(isPresented: $showPurchaseTrips, content: PurchaseTrips.init)
            }
            .padding(.horizontal, 25)
            
            OldPassView()
        }
    }
}

struct ShuttleBusMain_Previews: PreviewProvider {
    static var previews: some View {
        ShuttleBusMain(fromBike: .constant(false), rewardEarned: .constant(false))
    }
}
