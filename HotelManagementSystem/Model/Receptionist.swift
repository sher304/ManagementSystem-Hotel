//
//  Receptionist.swift
//  HotelManagementSystem
//
//  Created by Шермат Эшеров on 3/6/26.
//

import Foundation
import SwiftData

@available(iOS 26.0, macOS 26.0, *)
@Model
class Receptionist: Employee {
    
    var deskNumber: Int
    
    init(deskNumber: Int, hireDate: Date, languages: [String], person: Person) {
        self.deskNumber = deskNumber
        super.init(hireDate: hireDate, languages: languages, person: person)
    }
}
