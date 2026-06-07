//
//  EmployeeService.swift
//  HotelManagementSystem
//
//  Created by Шермат Эшеров on 3/6/26.
//

import Foundation
import SwiftData

class EmployeeService {
    
    private let repository: BaseRepository<Employee>
    private let personService: PersonService
    
    init(context: ModelContext) {
        self.repository = BaseRepository<Employee>(context: context)
        self.personService = PersonService(context: context)
    }
    
    public func createEmployee(pesel: String, hireDate: Date, languages: [String]) -> Employee? {
        guard let person = personService.getPerson(pesel: pesel) else {
            print("Error: Cannot create customer. Person with PESEL \(pesel) not found.")
            return nil
        }
        
        if person.employee != nil {
            print("This person is already an employee!")
            return person.employee
        }
        
        let newEmployee = Employee(hireDate: hireDate, languages: languages, person: person)
        repository.add(newEmployee)
        personService.setEmployeeRole(pesel: pesel, employee: newEmployee)
        print("Successfully created and linked new Employee!")
        return newEmployee
    }
    
    public func getEmployee(pesel: String) -> Employee? {
        return repository.fetchAll().first { employee in
            employee.person?.pesel == pesel
        }
    }
    
    public func getEmployees() -> [Employee] {
        return repository.fetchAll()
    }
    
    public func calculateSalary(pesel: String) -> Double {
        guard let employee = getEmployee(pesel: pesel) else {
            print("Error: Employee not found.")
            return 0.0
        }
        return employee.baseMinimumSalary
    }
    
    public func terminateContract(pesel:String, date: Date) {
        guard let employee = getEmployee(pesel: pesel) else {
            print("Employee not presented")
            return
        }
        
        if date < employee.hireDate ?? Date() {
            print("Hire date has to be less than termin date")
            return
        }
        
        employee.terminDate = date
        repository.saveChanges()
        print("Employee termin date has been updated")
    }
    
    public func getWorkingYears(pesel: String) -> Int? {
        guard let employee = getEmployee(pesel: pesel) else {
            print("Employee not presented")
            return nil
        }
        
        let startDate = employee.hireDate ?? Date()
        let endDate = employee.terminDate ?? Date()
        let components = Calendar.current.dateComponents([.year], from: startDate, to: endDate)
        return components.year ?? 0
    }
    
    public func addNewEmployee(pesel: String, employee: Employee) {
        repository.add(employee)
    }
    
    public func saveChanges() {
        repository.saveChanges()
    }
    
    public func deleteEmployee(employee: Employee) {
        repository.delete(employee)
    }
}
