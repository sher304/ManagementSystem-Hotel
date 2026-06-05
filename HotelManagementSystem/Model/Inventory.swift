//
//  Inventory.swift
//  HotelManagementSystem
//
//  Created by Шермат Эшеров on 3/6/26.
//

import Foundation
import SwiftData

@Model
class Inventory {
    @Attribute(.unique) var id: UUID = UUID()
    var title: String
    
    var employee: Employee
    
    init(title: String, employee: Employee) {
        self.title = title
        self.employee = employee
    }
}
