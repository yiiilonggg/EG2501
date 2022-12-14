//
//  OldPassView.swift
//  EG2501 App
//
//  Created by Yi Long on 25/10/22.
//

import SwiftUI

struct OldPassView: View {
    @State private var showPasses: Bool = false
    @State var tripSelected: Trip = blankTrip
    
    var body: some View {
        HStack {
            Text("Pass History")
                .font(.title)
                .fontWeight(.semibold)
            
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top, 5)
        
        ForEach(pastTripsCore) { trip in
            Button(action: {
                tripSelected.copyTrip(inTrip: trip)
                showPasses.toggle()
            }) {
                VStack(alignment: .leading) {
                    HStack {
                        Text(trip.name)
                            .font(.title2)
                            .bold()
                        
                        Spacer()
                        
                        Text(trip.busId)
                    }
                    .padding(.top, 10)
                    
                    Text("Pick-Up Date and Time: \(trip.startDate), \(trip.time)")
                    
                    Text("Pick-up Location: \(trip.pickUpLocation)")
                    
                    Text("Additional Information: \(trip.additionalInfo)")
                        .padding(.bottom, 10)
                }
            }
            .fullScreenCover(isPresented: $showPasses) {
                ViewPass(inPass: tripSelected, oldTrip: true)
            }
            .padding(.horizontal)
            .foregroundColor(.black)
            .background(LinearGradient(colors: trip.additionalInfo == "One-Time Trip" ? [.gray, .mint] : [.gray, .yellow], startPoint: .leading, endPoint: .trailing))
            .cornerRadius(10)
        }
        .frame(width: 400, height: CGFloat(pastTripsCore.count) * 40)
    }
}

struct OldPassView_Previews: PreviewProvider {
    static var previews: some View {
        OldPassView()
            .previewLayout(.fixed(width: 400, height: CGFloat(pastTripsCore.count) * 40))
    }
}
