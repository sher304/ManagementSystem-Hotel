//
//  Reservation.swift
//  HotelManagementSystem
//
//  Created by Шермат Эшеров on 3/6/26.
//

import Foundation
import SwiftData

@Model
class Reservation {
    @Attribute(.unique) var id: UUID = UUID()
    var isCancelled: Bool
    var checkInDate: Date
    var checkOutDate: Date
    var cancelReason:String?
    var room: Room?
    var customer: Customer
    
    @Relationship(inverse: \Payment.reservation)
    var payment: [Payment] = []
    
    init(isCancelled: Bool, checkInDate: Date,
         checkOutDate: Date, cancelReason: String? = nil,
         room: Room, customer: Customer) {
        self.isCancelled = isCancelled
        self.checkInDate = checkInDate
        self.checkOutDate = checkOutDate
        self.cancelReason = cancelReason
        self.room = room
        self.customer = customer
    }
}
