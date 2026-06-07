//
//  DeveloperSettingsView.swift
//  HotelManagementSystem
//
//  Created by Шермат Эшеров on 6/6/26.
//

import SwiftUI
import SwiftData

struct DeveloperSettingsView: View {
    @Environment(\.modelContext) private var context
    
    @State private var didSeedData = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Image(systemName: "server.rack")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.blue)
                
                Text("Developer Tools")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Use this button to flood the database with the initial setup data.")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                
                Button(action: {
                    let seeder = MockDataRepository(context: context)
                    
                    seeder.seedDatabase()
                    
                    didSeedData = true
                }) {
                    Text("Load Mock Data")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(didSeedData ? Color.green : Color.blue)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 40)
                
                if didSeedData {
                    Text("✅ Database Successfully Seeded!")
                        .foregroundColor(.green)
                        .fontWeight(.semibold)
                }
                
                Spacer()
            }
            .padding()
        }
    }
}
#Preview {
    DeveloperSettingsView()
}
