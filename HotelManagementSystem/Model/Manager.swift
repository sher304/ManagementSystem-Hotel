//
//  Manager.swift
//  HotelManagementSystem
//
//  Created by Шермат Эшеров on 3/6/26.
//

import Foundation
import SwiftData

@available(iOS 26.0, macOS 26.0, *)
@Model
class Manager: Employee {
 
    var certificates: [String]
    
    init(certificates: [String], hireDate: Date, languages: [String], person: Person) {
        self.certificates = certificates
        super.init(hireDate: hireDate, languages: languages, person: person)
    }
}
