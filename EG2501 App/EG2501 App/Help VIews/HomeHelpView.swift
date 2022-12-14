//
//  HomeHelpView.swift
//  EG2501 App
//
//  Created by Yi Long on 11/11/22.
//

import SwiftUI

struct HomeHelpView: View {
    var body: some View {
        ScrollView {
            Text("Welcome to Punggol Connect!\n")
                .font(.title)
            
            Text("As this app was built as a prototype, some intended features may not be presented. Do look out for these buttons throughout the app and tap them! It will provide more information on our ideas and some explanations to bridge the gap between this prototype and our envisioned solution.\n\nWe hope you have an enjoyable experience using the app with us :)\n\nWarmest Regards,\nEG2501 AY22/23 P5T4")
                .font(.title3)
            
            Spacer()
        }
        .padding()
    }
}

struct HomeHelpView_Previews: PreviewProvider {
    static var previews: some View {
        HomeHelpView()
    }
}
