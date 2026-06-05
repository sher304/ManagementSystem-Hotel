//
//  HotelManagementSystemApp.swift
//  HotelManagementSystem
//
//  Created by Шермат Эшеров on 3/6/26.
//

import SwiftUI
import SwiftData

@main
struct HotelManagementSystemApp: App {
    var sharedModelContainer: ModelContainer = {
        
        let schema = Schema([
            Hotel.self,
            Room.self,
            Person.self,
            Customer.self,
            Employee.self,
            Receptionist.self,
            Manager.self,
            Housekeeper.self,
            Department.self,
            Facility.self,
            Security.self,
            Inventory.self,
            Reservation.self,
            Payment.self
        ])
        
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            print("DATABASE PATH: ", modelConfiguration.url.path(percentEncoded: false))
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create the database tables: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
