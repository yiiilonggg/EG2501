//
//  PurchaseTripsHelpView.swift
//  EG2501 App
//
//  Created by Yi Long on 11/11/22.
//

import SwiftUI

struct PurchaseTripsHelpView: View {
    var body: some View {
        ScrollView {
            Text("Demand-Signalling System\n")
                .font(.title)
            
            Text("One unique feature of our shuttle bus is the demand-based system of the routes. For example, let's assume that there are currently no trips to Jurong West. Punggol residents then can signal that they want a route to the Jurong West area. After a significant amount of residents have signalled the same destination, a new route will be formed and residents will be notified.\n\nThis allows us to be flexible in the routes we offer and also ensure that shuttle buses introduced onto the roads by Punggol Connect are efficiently used.")
                .font(.title3)
            
            Spacer()
        }
        .padding()
    }
}

struct PurchaseTripsHelpView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseTripsHelpView()
    }
}
