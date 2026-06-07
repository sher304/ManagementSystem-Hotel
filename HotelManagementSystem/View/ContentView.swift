//
//  ContentView.swift
//  HotelManagementSystem
//
//  Created by Шермат Эшеров on 3/6/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    
    var body: some View {
        SearchCustomerView(context: context)
            .onAppear {
                let seeder = MockDataRepository(context: context)
                seeder.seedDatabase()
            }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [
            Hotel.self, Employee.self, Person.self, Customer.self,
            Reservation.self, Room.self, Department.self, Facility.self
        ], inMemory: true)
}
