//
//  PaymentStatus.swift
//  HotelManagementSystem
//
//  Created by Шермат Эшеров on 3/6/26.
//

import Foundation

enum PaymentStatus: String, Codable {
    case pending = "Pending"
    case paid = "Paid"
    case failed = "Failed"
    case refunded = "Refunded"
}
