//
//  Facility.swift
//  HotelManagementSystem
//
//  Created by Шермат Эшеров on 3/6/26.
//

import Foundation
import SwiftData

@Model
class Facility {
    @Attribute(.unique) var id: UUID = UUID()
    var title: String
    var maxCapacity: Int
    var openingHours: Date
    
    var department: Department
    
    init(title: String, maxCapacity: Int,
         openingHours: Date, department: Department) {
        self.title = title
        self.maxCapacity = maxCapacity
        self.openingHours = openingHours
        self.department = department
    }
}
