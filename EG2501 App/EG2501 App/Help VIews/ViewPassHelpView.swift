//
//  ViewPassHelpView.swift
//  EG2501 App
//
//  Created by Yi Long on 11/11/22.
//

import SwiftUI

struct ViewPassHelpView: View {
    var body: some View {
        ScrollView {
            Text("Passes as Bus Cards!\n")
                .font(.title)
            
            Text("One strange challenge our group discussed was how would a shuttle bus captain know if an individual is an intended passenger?\n\nAdopting the idea of passengers scanning their bus cards while boarding a bus, users who successfully booked a seat will be able to activate a unique 'bus card'. This will allow them to scan at the correct shuttle bus' scanner. We believe that this is a feasible solution as our phones are capable of being our digital wallets, with services such as Apple pay allow phones to serve as credit/debit cards.")
                .font(.title3)
            
            Spacer()
        }
        .padding()
    }
}

struct ViewPassHelpView_Previews: PreviewProvider {
    static var previews: some View {
        ViewPassHelpView()
    }
}
