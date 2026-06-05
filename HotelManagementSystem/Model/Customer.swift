//
//  Customer.swift
//  HotelManagementSystem
//
//  Created by Шермат Эшеров on 3/6/26.
//

import Foundation
import SwiftData

@Model
class Customer {
    var loayltyPoints: Int
    
    var person: Person
    
    @Relationship(inverse: \Reservation.customer)
    var reservation: [Reservation] = []
    
    init(loayltyPoints: Int, person: Person) {
        self.loayltyPoints = loayltyPoints
        self.person = person
    }
}
