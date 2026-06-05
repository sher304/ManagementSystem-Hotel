//
//  Housekeeper.swift
//  HotelManagementSystem
//
//  Created by Шермат Эшеров on 3/6/26.
//

import Foundation
import SwiftData

@available(iOS 26.0, macOS 26.0, *)
@Model
class Housekeeper: Employee {
    
    var assignedFloor: Int
    
    init(assignedFloor: Int, hireDate: Date, languages: [String], person: Person) {
        self.assignedFloor = assignedFloor
        super.init(hireDate: hireDate, languages: languages, person: person)
    }
}
