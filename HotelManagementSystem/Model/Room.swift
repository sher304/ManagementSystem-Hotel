//
//  Room.swift
//  HotelManagementSystem
//
//  Created by Шермат Эшеров on 3/6/26.
//

import Foundation
import SwiftData

@Model
class Room {
    @Attribute(.unique) var id: UUID = UUID()
    var number: Int
    var floor: Int
    var lastCleanedDate: Date
    var smokeAllowed: Bool
    var capacity: Int
    @Attribute(originalName: "description")
    var description_: String
    var status: RoomStatus
    var imageName: String?
    
    var hotel: Hotel
    
    @Relationship(deleteRule: .cascade, inverse: \Reservation.room)
    var reservations: [Reservation] = []
    
    init(number: Int, floor: Int, lastCleanedDate: Date, smokeAllowed: Bool,
         capacity: Int, description: String, status: RoomStatus,
         hotel: Hotel, imageName: String? = nil) {
        self.number = number
        self.floor = floor
        self.lastCleanedDate = lastCleanedDate
        self.smokeAllowed = smokeAllowed
        self.capacity = capacity
        self.description_ = description
        self.status = status
        self.hotel = hotel
        self.imageName = imageName
    }
}
