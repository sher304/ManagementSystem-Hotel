//
//  Department.swift
//  HotelManagementSystem
//
//  Created by Шермат Эшеров on 3/6/26.
//

import Foundation
import SwiftData

@Model
class Department {
    var title: String
    var floor: Int
    var budget: Double
    var seasonEndDate: Date?
    
    @Relationship(deleteRule: .cascade, inverse: \Facility.department)
    var facilities: [Facility] = []
    
    @Relationship(inverse: \Employee.department)
    var employees: [Employee] = []
    
    init(title: String, floor: Int, budget: Double, seasonEndDate: Date? = nil) {
        self.title = title
        self.floor = floor
        self.budget = budget
        self.seasonEndDate = seasonEndDate
    }
}
