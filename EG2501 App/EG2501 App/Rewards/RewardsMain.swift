//
//  RewardsMain.swift
//  EG2501 App
//
//  Created by Yi Long on 22/10/22.
//

import SwiftUI

struct RewardsMain: View {
    @State private var showRedemptions: Bool = false
    @State var categoriesList = rewardsCategoriesCore
    
    var body: some View {
        ScrollView {
            HStack {
                Image(systemName: "gift.fill")
                    .font(.system(size: 45))
                    .foregroundColor(.purple)
                
                VStack(alignment: .leading) {
                    Text("Rewards")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("You have \(profileTracker.points, specifier: "%.2f") points to spend")
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                Spacer()
            }
            .padding([.horizontal, .bottom])
            
            
            List(categoriesList) { cat in
                Button(action: {
                    showRedemptions.toggle()
                }) {
                    Text(cat.name)
                        .font(.title)
                        .foregroundColor(.white)
                        .offset(x: cat.wordOffsetX)
                }
                .frame(width: 350, height: 75)
                .fullScreenCover(isPresented: $showRedemptions) {
                    RewardsDetails()
                }
                .listRowBackground(cat.col)
                .listRowSeparatorTint(Color.black)
                .overlay(
                    Image(systemName: cat.image)
                        .font(.system(size: cat.imageSize))
                        .offset(x: cat.imageOffsetX, y: cat.imageOffsetY)
                        .foregroundColor(.white)
                )
            }
            .listStyle(.plain)
            .cornerRadius(20)
            .frame(width: 370, height: 800)
            .scrollDisabled(true)
        }
    }
}

struct RewardsMain_Previews: PreviewProvider {
    static var previews: some View {
        RewardsMain()
    }
}
