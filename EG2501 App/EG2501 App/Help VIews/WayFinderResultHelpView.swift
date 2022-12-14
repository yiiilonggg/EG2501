//
//  WayFinderResultHelpView.swift
//  EG2501 App
//
//  Created by Yi Long on 11/11/22.
//

import SwiftUI

struct WayFinderResultHelpView: View {
    var body: some View {
        ScrollView {
            Text("Providing Real-Time Trip Data\n")
                .font(.title)
            
            Text("To provide accurate timings for the various trips by cycling, train and bus, it is vital that we obtain real-time traffic information to compute these travel timings for our users. One possible collaboration would be with LTA, from whom we can obtain real time traffic data and dervive accurate timings for the respective modes of transport.\n\nWhilst we aim to obtain a high pick-up rate, we should also provide honest results to our users and maintain trust amongst our consumers.\n\nOne additional information we can include in this page is the crowd-level at the nearest public transport points. High crowd-levels can be a key deciding factor for users who were previously 'on-the-fence' about cycling to their destination.")
                .font(.title3)
            
            Spacer()
        }
        .padding()
    }
}

struct WayFinderResultHelpView_Previews: PreviewProvider {
    static var previews: some View {
        WayFinderResultHelpView()
    }
}
