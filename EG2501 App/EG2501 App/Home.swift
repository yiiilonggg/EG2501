//
//  Home.swift
//  EG2501 App
//
//  Created by Yi Long on 22/10/22.
//

import SwiftUI

struct Home: View {
    @State private var showingAlert = false
    var body: some View {
        NavigationView {
            ScrollView {
                HStack {
                    Image(systemName: "house.fill")
                        .font(.system(size: 45))
                        .foregroundColor(.teal)
                    Text("Home")
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .offset(y: 10)
                    
                    Spacer()
                    
                    Button(action: {
                        showingAlert = true
                    }) {
                        Image(systemName: "exclamationmark.circle.fill")
                            .foregroundColor(.purple)
                            .font(.system(size: 30))
                            .offset(y: 10)
                    }
                    .sheet(isPresented: $showingAlert) {
                        HomeHelpView()
                            .presentationDetents([.medium])
                    }
                }
                .padding([.leading, .bottom, .trailing])
                
                Text("Good Morning \(profileTracker.name), how may we help you today?")
                    .font(.title2)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.leading)
                    .padding([.leading, .bottom, .trailing])
                
                ForEach(categoryCore, id: \.self.id) { category in
                    NavigationLink(destination: category.destination) {
                        Text(category.name)
                            .font(.largeTitle)
                            .fontWeight(.regular)
                            .foregroundColor(Color.white)
                            .offset(x: category.wordOffset)
                    }
                    .frame(width: 350, height: 100)
                    .background(category.col)
                    .cornerRadius(20)
                    .controlSize(.large)
                    .overlay(
                        Image(systemName: category.icon)
                            .font(.system(size: 50))
                            .offset(x: 125)
                            .foregroundColor(.white)
                    )
                    .padding(.horizontal)
                }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
