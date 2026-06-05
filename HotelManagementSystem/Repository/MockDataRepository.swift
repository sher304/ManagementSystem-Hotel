//
//  MockDataRepository.swift
//  HotelManagementSystem
//
//  Created by Шермат Эшеров on 4/6/26.
//

import Foundation
import SwiftData

class MockDataRepository {
    
    @MainActor
    static func seedInitialData(context: ModelContext) {
        let hotelDescriptor = FetchDescriptor<Hotel>()
        let existingHotels = (try? context.fetch(hotelDescriptor)) ?? []
        
        if !existingHotels.isEmpty {
            print("Database already has data. Skipping seed.")
            return
        }
        
        print("Seeding initial database records...")
        
        let mainHotel = Hotel(
            title: "The Grand Warsaw",
            address: "Złota 44, Warsaw",
            starRating: 5.0,
            totalFloors: 10,
            checkInTime: Date(),
            checkOutTime: Date(),
            maximumCapacity: 500,
            description: "Luxury hotel in the heart of the city."
        )
        context.insert(mainHotel)
        
        let fitnessDept = Department(title: "Health & Wellness", floor: 2, budget: 15000.0)
        context.insert(fitnessDept)
        
        let poolFacility = Facility(title: "Indoor Heated Pool", maxCapacity: 50, openingHours: Date(), department: fitnessDept)
        context.insert(poolFacility)
        
        let room101 = Room(number: 101, floor: 1, lastCleanedDate: Date(), smokeAllowed: false, capacity: 2, description: "Standard Queen", status: .free, hotel: mainHotel)
        let room102 = Room(number: 102, floor: 1, lastCleanedDate: Date(), smokeAllowed: false, capacity: 4, description: "Family Suite", status: .free, hotel: mainHotel)
        let room103 = Room(number: 103, floor: 1, lastCleanedDate: Date(), smokeAllowed: false, capacity: 2, description: "Standard Queen", status: .booked, hotel: mainHotel)
        
        context.insert(room101)
        context.insert(room102)
        context.insert(room103)
        
        let johnPerson = Person(pesel: "90010112345", firstName: "John", lastName: "Doe", phoneNumber: "555-0101", email: "john@example.com", dateOfBirth: Date())
        let janePerson = Person(pesel: "85020298765", firstName: "Jane", lastName: "Smith", phoneNumber: "555-0202", email: "jane@example.com", dateOfBirth: Date())
        
        context.insert(johnPerson)
        context.insert(janePerson)
        
        let johnCustomer = Customer(loayltyPoints: 1500, person: johnPerson)
        context.insert(johnCustomer)
        
        let janeManager = Manager(certificates: ["Advanced Hospitality"], hireDate: Date(), languages: ["English", "Polish"], person: janePerson)
        janeManager.department = fitnessDept
        context.insert(janeManager)
        
        do {
            try context.save()
            print("Successfully seeded the database!")
        } catch {
            print("Failed to seed database: \(error)")
        }
    }
}
