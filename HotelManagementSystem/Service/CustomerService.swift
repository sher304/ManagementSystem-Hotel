//
//  CustomerService.swift
//  HotelManagementSystem
//
//  Created by Шермат Эшеров on 3/6/26.
//

import Foundation
import SwiftData

class CustomerService {
    
    private let repository: BaseRepository<Customer>
    private let personService: PersonService
    
    init(context: ModelContext) {
        self.repository = BaseRepository<Customer>(context: context)
        self.personService = PersonService(context: context)
    }
    
    public func createCustomer(pesel: String) -> Customer? {
        guard let person = personService.getPerson(pesel: pesel) else {
            print("Error: Cannot create customer. Person with PESEL \(pesel) not found.")
            return nil
        }
        
        if person.customer != nil {
            print("This person is already a customer!")
            return person.customer
        }
        
        let newCustomer = Customer(loayltyPoints: 0, person: person)
        repository.add(newCustomer)
        personService.setCustomerRole(pesel: pesel, customer: newCustomer)
        print("Successfully created and linked new Customer!")
        return newCustomer
    }
    
    public func getCustomer(pesel: String) -> Customer? {
        return repository.fetchAll().first { customer in
            customer.person.pesel == pesel
        }
    }
    
    public func getAllCustomers() -> [Customer] {
        return repository.fetchAll()
    }
    
    public func updatePoints(customer: Customer, points: Int) {
        customer.loayltyPoints += points
        print("Updated loaylty points")
        repository.saveChanges()
    }
}
