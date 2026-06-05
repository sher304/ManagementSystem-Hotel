//
//  PersonService.swift
//  HotelManagementSystem
//
//  Created by Шермат Эшеров on 3/6/26.
//

import Foundation
import SwiftData

class PersonService {
    
    private let repository: BaseRepository<Person>
    
    init(context: ModelContext) {
        self.repository = BaseRepository<Person>(context: context)
    }
    
    public func getPeople() -> [Person] {
        return repository.fetchAll()
    }
    
    public func getPerson(pesel: String) -> Person? {
        return repository.fetchAll().first { person in
            person.pesel == pesel
        }
    }
    
    public func setCustomerRole(pesel: String, customer: Customer) {
        guard let person = getPerson(pesel: pesel) else {
            print("Person with this PESEL is not exist")
            return
        }
        
        if person.customer != nil  {
            print("This person is already a customer")
            return
        }
        
        person.setCustomerRole(customer: customer)
        repository.saveChanges()
        print("CUSTOMER ROLE SETTED")
    }
    
    public func setEmployeeRole(pesel: String, employee: Employee) {
        guard let person = getPerson(pesel: pesel) else {
            print("Person with this PESEL is not exist")
            return
        }
        
        if person.employee != nil {
            print("This person is already an employee")
            return
        }
        
        person.setEmployeeRole(employee: employee)
        repository.saveChanges()
        print("Employee role setted")
    }
    
    func createPerson(pesel: String, firstName: String,
                      lastName: String, phoneNumber: String,
                      email: String, dateOfBirth: Date) -> Person? {
        if getPerson(pesel: pesel) != nil {
            print("Person with this PESEL is already exists")
            return nil
        }
        
        let newPerson = Person(pesel: pesel, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, email: email, dateOfBirth: dateOfBirth)
        
        repository.add(newPerson)
        return newPerson
    }
    
    public func update(pesel: String, firstName: String?,
                lastName: String?, phoneNumber: String?,
                email: String?, dateOfBirth: Date?) {
        guard let person = getPerson(pesel: pesel) else {
            print("Error: Person with PESEL \(pesel) not found.")
            return
        }
        
        if let firstName { person.firstName = firstName }
        if let lastName { person.lastName = lastName }
        if let phoneNumber { person.phoneNumber = phoneNumber }
        if let email { person.email = email }
        if let dateOfBirth { person.dateOfBirth = dateOfBirth }
        
        repository.saveChanges()
        
        print("Successfully updated profile for \(person.firstName).")
    }
    
    public func delete(pesel: String) {
        guard let person = getPerson(pesel: pesel) else {
            print("Error: Person with PESEL \(pesel) not found.")
            return
        }
        
        repository.delete(person)
        print("Person has been deleted")
    }
}
