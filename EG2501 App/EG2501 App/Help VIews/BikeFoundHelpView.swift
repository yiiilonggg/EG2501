//
//  BikeFoundHelpView.swift
//  EG2501 App
//
//  Created by Yi Long on 11/11/22.
//

import SwiftUI

struct BikeFoundHelpView: View {
    var body: some View {
        ScrollView {
            Text("Point-Reward System\n")
                .font(.title)
            
            Text("Punggol Connect aims to implement a point system that incentivises trips with the following characteristics:\n1. Two-way trips\n2. Destinations docks which have lower bike concentrations\n3. Trips during peak hour periods\n\nThe main motivations for these conditions were to tackle the issues of uneven distributions of bikes and to incentivise cycling. This is especially so during peak hour periods, when the burden on public transport systems are highest.")
                .font(.title3)
            
            Spacer()
        }
        .padding()
    }
}

struct BikeFoundHelpView_Previews: PreviewProvider {
    static var previews: some View {
        BikeFoundHelpView()
    }
}
