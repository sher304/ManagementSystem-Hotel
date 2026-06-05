//
//  Payment.swift
//  HotelManagementSystem
//
//  Created by Шермат Эшеров on 3/6/26.
//

import Foundation
import SwiftData

@Model
class Payment {
    @Attribute(.unique) var id: UUID = UUID()
    var date: Date
    var status: PaymentStatus
    var paymentType: String
    var paymentAmount: Double
    
    var reservation: Reservation?
    
    init(date: Date, status: PaymentStatus,
         paymentType: String, paymentAmount: Double,
         reservation: Reservation) {
        self.date = date
        self.status = status
        self.paymentType = paymentType
        self.paymentAmount = paymentAmount
        self.reservation = reservation
    }
}
