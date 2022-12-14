//
//  ProfileMainHelpView.swift
//  EG2501 App
//
//  Created by Yi Long on 11/11/22.
//

import SwiftUI

struct ProfileMainHelpView: View {
    var body: some View {
        ScrollView {
            Text("Integration with Singpass\n")
                .font(.title)
            
            Text("Having users register onto Punggol Connect with their Singpass accounts is to identify users who have mishandled the resources of the app. For example, if a user has exceeded their maximum loan time of the bike ride, or travelled out of Punggol with the bike, a time-out period will be imposed on the user. More severe punishments can be enforced onto repeat offenders as well.")
                .font(.title3)
            
            Spacer()
        }
        .padding()
    }
}

struct ProfileMainHelpView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileMainHelpView()
    }
}
