//
//  Hotel.swift
//  HotelManagementSystem
//
//  Created by Шермат Эшеров on 3/6/26.
//

import Foundation
import SwiftData

@Model
class Hotel {
    @Attribute(.unique)
    var id: UUID
    var title: String
    var address: String
    var starRating: Double
    var totalFloors: Int
    var checkInTime: Date
    var checkOutTime: Date
    var maximumCapacity: Int
    @Attribute(originalName: "description")
    var description_: String
    var startingPrice: Double = 450.0
    
    @Relationship(deleteRule: .cascade, inverse: \Room.hotel)
    var rooms: [Room] = []
    
    @Relationship(inverse: \Security.hotel)
    private(set) var securities: [Security] = []

    private init(id: UUID = UUID(), title: String, address: String, starRating: Double,
         totalFloors: Int, checkInTime: Date, checkOutTime: Date,
         maximumCapacity: Int, description: String) {
        self.id = id
        self.title = title
        self.address = address
        self.starRating = starRating
        self.totalFloors = totalFloors
        self.checkInTime = checkInTime
        self.checkOutTime = checkOutTime
        self.maximumCapacity = maximumCapacity
        self.description_ = description
    }
    
    static func createHotel(title: String, address: String, starRating: Double,
                            totalFloors: Int, checkInTime: Date, checkOutTime: Date,
                            maximumCapacity: Int, description: String,
                            roomNumber: Int, capacity: Int) -> Hotel {
        let newHotel = Hotel(title: title, address: address, starRating: starRating, totalFloors: totalFloors, checkInTime: checkInTime, checkOutTime: checkOutTime, maximumCapacity: maximumCapacity, description: description)
        let mandatoryRoom = Room(
            number: roomNumber,
            floor: 1,
            lastCleanedDate: Date(),
            smokeAllowed: false,
            capacity: capacity,
            description: "Base Room",
            status: .free,
            hotel: newHotel
        )
        return newHotel
    }
    
    public func addSecurity(_ security: Security) {
        self.securities.append(security)
    }
}
