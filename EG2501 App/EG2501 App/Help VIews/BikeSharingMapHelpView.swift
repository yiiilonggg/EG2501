//
//  BikeSharingMapHelpView.swift
//  EG2501 App
//
//  Created by Yi Long on 11/11/22.
//

import SwiftUI

struct BikeSharingMapHelpView: View {
    var body: some View {
        ScrollView {
            Text("Bike Sharing Map Real Time Data\n")
                .font(.title)
            
            Text("This bike sharing map aims to show the users two pieces of important information:\n1. if there is a bike available for them at the origin bike dock,\n2. if there is a dock they can park their loaned bike at the destination bike dock\n\nThis allows the system to preallocate a user a bike and secure him/her a docking point in the destination.")
                .font(.title3)
            
            Spacer()
        }
        .padding()
    }
}

struct BikeSharingMapHelpView_Previews: PreviewProvider {
    static var previews: some View {
        BikeSharingMapHelpView()
    }
}
