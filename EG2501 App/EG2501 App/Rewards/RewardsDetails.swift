//
//  RewardsDetails.swift
//  EG2501 App
//
//  Created by Yi Long on 22/10/22.
//

import SwiftUI

struct RewardsDetails: View {
    @Environment(\.presentationMode) var presentationMode
    @State var points = profileTracker.points
    @State var rewardList = rewardsListCore
    
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
            
            Text("Popular Redemptions")
                .font(.title)
                .bold()
                .foregroundColor(.orange)
            
            Text("You have \(points, specifier: "%.2f") points to spend!")
                .font(.title3)
                .bold()
            
            List(rewardList) { reward in
                VStack(spacing: 0.0) {
                    HStack() {
                        Image(reward.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 50)
                        
                        Spacer()
                        
                        Text(reward.name)
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                    }
                    .border(.gray)
                    
                    HStack(spacing: 0.0) {
                        Text("\(reward.points, specifier: "%.0f") Points")
                            .frame(width: 160, height: 50)
                            .border(.gray)
                        Text("Use by: " + String(reward.usedBy))
                            .frame(width: 200, height: 50)
                            .border(.gray)
                    }
                    
                    if (reward.redeemed) {
                        Text("Redeemed on " + reward.redeemedDate)
                            .frame(width: 360, height: 50)
                            .background(LinearGradient(colors: [.cyan, .blue], startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(10)
                    } else {
                        if (reward.points > points) {
                            Text("Insufficient Points")
                                .frame(width: 360, height: 50)
                                .background(LinearGradient(colors: [.pink, .yellow], startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(10)
                        } else {
                            Text("Redeem!")
                                .frame(width: 360, height: 50)
                                .background(LinearGradient(colors: [.green, .mint], startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(10)
                        }
                    }
                }
                .listRowSeparatorTint(.black)
            }
            .listStyle(.plain)
            .cornerRadius(10)
            .frame(width: 350, height: CGFloat(rewardList.count) * 175)
            .scrollDisabled(true)
        }
    }
}

struct RewardsDetails_Previews: PreviewProvider {
    static var previews: some View {
        RewardsDetails()
    }
}
