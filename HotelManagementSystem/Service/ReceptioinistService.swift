//
//  ReceptioinistService.swift
//  HotelManagementSystem
//
//  Created by Шермат Эшеров on 3/6/26.
//

import Foundation
import SwiftData

class ReceptioinistService {
    private let customerService: CustomerService
    private let reservationRepository: BaseRepository<Reservation>
    private let personService: PersonService
    private let employeeService: EmployeeService
    
    init(context: ModelContext) {
        self.customerService = CustomerService(context: context)
        self.reservationRepository = BaseRepository<Reservation>(context: context)
        self.employeeService = EmployeeService(context: context)
        self.personService = PersonService(context: context)
    }
    
    public func createReceptionist(pesel: String, hireDate: Date,
                                   deskNumber: Int,
                                   baseMinimumSalary: Double, languages: [String]) -> Receptionist? {
        guard let person = personService.getPerson(pesel: pesel) else {
            print("Error: Person with PESEL \(pesel) not found.")
            return nil
        }
        
        if person.employee != nil {
            print("This person is already employed here!")
            return person.employee as? Receptionist
        }
        
        let newReceptionist = Receptionist(deskNumber: deskNumber,
                                           hireDate: hireDate,
                                           languages: languages,
                                           person: person)
        employeeService.addNewEmployee(pesel: pesel, employee: newReceptionist)
        newReceptionist.hireDate = hireDate
        newReceptionist.languages = languages
        newReceptionist.person = person
        employeeService.saveChanges()
        print("Successfully created Receptionist profile.")
        return newReceptionist
    }
    
    public func verifyCustomer(pesel: String) -> Bool {
        if customerService.getCustomer(pesel: pesel) != nil {
            print("Customer verified successfully.")
            return true
        } else {
            print("Customer not found in the system.")
            return false
        }
    }
        
    public func processCheckIn(reservation: Reservation) {
        reservation.room?.status = .booked
        reservationRepository.saveChanges()
        print("Check-in processed successfully. Room locked.")
    }
    
    public func processCheckOut(reservation: Reservation) {
        reservation.room?.status = .cleaning
        customerService.updatePoints(customer: reservation.customer, points: 100)
    
        reservationRepository.saveChanges()
        print("Check-out processed. Room requires cleaning.")
    }
    
    public func cancelCheckIn(reservation: Reservation) {
        reservation.room?.status = .free
        reservationRepository.delete(reservation)
        print("Reservation cancelled and room freed.")
    }
    
    public func update(receptionist: Receptionist) {
        employeeService.saveChanges()
        print("Receptionist details successfully updated.")
    }
    
    public func remove(receptionist: Receptionist) {
        employeeService.deleteEmployee(employee: receptionist)
        print("Receptionist details successfully deleted.")
    }
}
