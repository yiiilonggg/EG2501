//
//  PurchasePasses.swift
//  EG2501 App
//
//  Created by Yi Long on 22/10/22.
//

import SwiftUI

struct PurchasePasses: View {
    @Environment(\.presentationMode) var presentationMode
    var normalPass: [Pass] = normalPassesCore
    var specialPass: [Pass] = specialPassesCore
    
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
                .padding()
                
                Spacer()
            }
            
            Text("Purchasing Passes")
                .font(.title)
                .bold()
                .padding(.horizontal)
                .padding(.top, 5)
            
            List(normalPass) { pass in
                HStack {
                    VStack(alignment: .leading) {
                        Text(pass.name)
                            .font(.title2)
                            .bold()
                        Text(pass.description)
                    }
                    Spacer()
                    Text("$" + String(pass.price))
                        .font(.title)
                }
                .listRowBackground(LinearGradient(colors: [.orange, .yellow], startPoint: .leading, endPoint: .trailing))
            }
            .listStyle(.plain)
            .cornerRadius(10)
            .frame(width: 350, height: CGFloat(normalPass.count) * 70)
            .scrollDisabled(true)
            
            Text("Special Plans")
                .font(.title)
                .bold()
                .padding(.horizontal)
            
            List(specialPass) { pass in
                HStack {
                    VStack(alignment: .leading) {
                        Text(pass.name)
                            .font(.title2)
                            .bold()
                        Text(pass.description)
                    }
                    Spacer()
                    Text("$" + String(pass.price))
                        .font(.title)
                }
                .listRowBackground(LinearGradient(colors: [.purple, .cyan], startPoint: .leading, endPoint: .trailing))
            }
            .listStyle(.plain)
            .cornerRadius(10)
            .frame(width: 350, height: CGFloat(specialPass.count) * 85)
            .scrollDisabled(true)
            
            Text("Are your buddies Punggolers too? Get them on board the bus!")
                .font(.title)
                .bold()
                .padding()
            
            Text("Referral Code")
                .font(.headline)
            
            Text("ABCDEFG")
                .font(.largeTitle)
                .bold()
                .frame(width: 300, height: 50)
                .background(Rectangle().border(.gray).foregroundColor(.white))
        }
        .scrollDisabled(false)
    }
}

struct PurchasePasses_Previews: PreviewProvider {
    static var previews: some View {
        PurchasePasses()
    }
}
