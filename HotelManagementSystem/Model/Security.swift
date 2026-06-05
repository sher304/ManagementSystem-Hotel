//
//  Security.swift
//  HotelManagementSystem
//
//  Created by Шермат Эшеров on 3/6/26.
//

import Foundation
import SwiftData

@Model
class Security {
    @Attribute(.unique) var id: UUID = UUID()
    var groupAmount: Int
    var postLocation: String
    var shiftStart: Date
    var shiftEnd: Date
    @Attribute(originalName: "description")
    var description_: String
    var phoneNumber: String
    
    var hotel: Hotel?
    
    init(groupAmount: Int, postLocation: String, shiftStart: Date, shiftEnd: Date, description: String, phoneNumber: String) {
        self.groupAmount = groupAmount
        self.postLocation = postLocation
        self.shiftStart = shiftStart
        self.shiftEnd = shiftEnd
        self.description_ = description
        self.phoneNumber = phoneNumber
    }
}
