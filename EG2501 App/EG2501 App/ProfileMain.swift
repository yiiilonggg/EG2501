//
//  ProfileMain.swift
//  EG2501 App
//
//  Created by Yi Long on 22/10/22.
//

import SwiftUI

struct ProfileMain: View {
    @State private var showingAlert: Bool = false
    @State private var pushNotif: Bool = false
    @State private var camera: Bool = false
    @State private var location: Bool = false
    
    var body: some View {
        ScrollView {
            HStack {
                Image(systemName: "person.fill")
                    .font(.system(size: 45))
                    .foregroundColor(.gray)
                
                Text("Profile")
                    .font(.largeTitle)
                    .fontWeight(.bold)
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
                    ProfileMainHelpView()
                        .presentationDetents([.medium])
                }
            }
            .padding([.horizontal, .bottom])
            
            VStack(alignment: .leading) {
                Text("Full Name")
                    .font(.title3)
                    .bold()
                    .padding(.horizontal)
                
                Text(profileTracker.name)
                    .font(.title3)
                    .bold()
                    .frame(width: 380, height: 50)
                    .border(.gray)
                    .padding(.horizontal)
                    .padding(.bottom)
                
                Text("Registered Email Address")
                    .font(.title3)
                    .bold()
                    .padding(.horizontal)
                
                Text("e0123456@u.nus.edu")
                    .font(.title3)
                    .bold()
                    .frame(width: 380, height: 50)
                    .border(.gray)
                    .padding(.horizontal)
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                    }) {
                        Text("Change email address")
                            .font(.headline)
                            .bold()
                            .foregroundColor(.blue)
                    }
                }
                .padding(.horizontal)
            }
            
            VStack {
                Toggle("Enable push notifications", isOn: $pushNotif)
                    .font(.title3)
                    .fontWeight(.medium)
                    .padding([.top, .leading, .trailing])
                
                Toggle("Enable location accuracy", isOn: $location)
                    .font(.title3)
                    .fontWeight(.medium)
                    .padding([.top, .leading, .trailing])
                
                Toggle("Enable camera access", isOn: $camera)
                    .font(.title3)
                    .fontWeight(.medium)
                    .padding([.top, .leading, .trailing])
            }
            
            HStack {
                VStack {
                    Text(String(profileTracker.passes))
                        .font(.largeTitle)
                        .bold()
                    Text("Passes")
                        .font(.headline)
                }
                .padding(.horizontal)
                .frame(width: 190, height: 100)
                .background(LinearGradient(colors: [.mint, .green], startPoint: .leading, endPoint: .trailing))
                .cornerRadius(10)
                
                VStack {
                    Text(String(profileTracker.points))
                        .font(.largeTitle)
                        .bold()
                    Text("Points")
                        .font(.headline)
                }
                .padding(.horizontal)
                .frame(width: 190, height: 100)
                .background(LinearGradient(colors: [.yellow, .pink], startPoint: .leading, endPoint: .trailing))
                .cornerRadius(10)
            }
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Cycle-to-Shuttle Progress")
                        .font(.title3)
                        .fontWeight(.medium)
                    
                    Spacer()
                    
                    Text("\(profileTracker.count)0%")
                        .font(.title3)
                        .fontWeight(.medium)
                }
                
                Rectangle()
                    .frame(width: 390, height: 20)
                    .foregroundColor(Color.white)
                    .border(LinearGradient(colors: [.indigo, .purple], startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(5)
                    .overlay(
                        Rectangle()
                            .frame(width: 39 * CGFloat(profileTracker.count))
                            .foregroundColor(.clear)
                            .background(LinearGradient(colors: [.indigo, .purple], startPoint: .leading, endPoint: .trailing)), alignment: .leading
                    )
            }
            .padding(.horizontal, 20)
            
            Button(action: {
                print("button pressed")
            }) {
                Text("View Ride History")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .frame(width: 350, height: 30)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .padding(.horizontal)
            .tint(.teal)
            
            Button(action: {
                print("button pressed")
            }) {
                Text("Manage Payment Services")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .frame(width: 350, height: 30)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .padding(.horizontal)
            .tint(.orange)
            
            Button(action: {
                print("button pressed")
            }) {
                Text("View Purchase History")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .frame(width: 350, height: 30)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .padding(.horizontal)
            .tint(.gray)
            Spacer()
        }
    }
}

struct ProfileMain_Previews: PreviewProvider {
    static var previews: some View {
        ProfileMain()
    }
}
