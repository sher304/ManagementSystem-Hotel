//
//  Employee.swift
//  HotelManagementSystem
//
//  Created by Шермат Эшеров on 3/6/26.
//

import Foundation
import SwiftData

@Model
class Employee {
    var hireDate: Date = Date()
    var terminDate: Date?
    var languages: [String] = []
    var baseMinimumSalary: Double = 52.0
    
    var person: Person?
    
    @Relationship(deleteRule: .nullify, inverse: \Inventory.employee)
    var employeeItems: [Inventory] = []
    
    var department: Department?
    
    init(hireDate: Date, languages: [String], person: Person) {
        self.hireDate = hireDate
        self.languages = languages
        self.person = person
    }
    
    // TODO: TERMIN DATE LOGIC HANDLE
}
