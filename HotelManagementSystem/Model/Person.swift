//
//  Person.swift
//  HotelManagementSystem
//
//  Created by Шермат Эшеров on 3/6/26.
//

import Foundation
import SwiftData


@Model
class Person {
 
    @Attribute(.unique)
    var pesel: String
    var firstName: String
    var lastName: String
    var phoneNumber: String
    var email: String
    var dateOfBirth: Date
    
    var password: String
    
    @Relationship(deleteRule: .cascade, inverse: \Employee.person)
    var employee: Employee?
    
    @Relationship(deleteRule: .cascade, inverse: \Customer.person)
    var customer: Customer?
    
    init(pesel: String, firstName: String, lastName: String,
         phoneNumber: String, email: String, dateOfBirth: Date,
         password: String) {
        self.pesel = pesel
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.email = email
        self.dateOfBirth = dateOfBirth
        self.password = password
    }
    
    public func setCustomerRole(customer: Customer) {
        self.customer = customer
    }
    
    public func setEmployeeRole(employee: Employee) {
        self.employee = employee
    }
}
