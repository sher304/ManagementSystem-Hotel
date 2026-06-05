//
//  ManagerService.swift
//  HotelManagementSystem
//
//  Created by Шермат Эшеров on 3/6/26.
//

import Foundation
import SwiftData

class ManagerService {
    private let departmentRepository: BaseRepository<Department>
    private let employeeService: EmployeeService
    private let personService: PersonService
    
    init(context: ModelContext) {
        self.departmentRepository = BaseRepository<Department>(context: context)
        self.employeeService = EmployeeService(context: context)
        self.personService = PersonService(context: context)
    }
    
    public func createManager(pesel: String, baseMinimumSalary: Double,
                              hireDate: Date,
                              languages: [String],
                              certificates: [String]) -> Manager? {
        guard let person = personService.getPerson(pesel: pesel) else {
            print("Error: Cannot create manager. Person not found.")
            return nil
        }
        
        if person.employee != nil {
            print("This person is already employed here!")
            return person.employee as? Manager
        }
        
        let newManager = Manager(certificates: certificates, hireDate: hireDate,
                                 languages: languages, person: person)
        
        employeeService.addNewEmployee(employee: newManager)
        print("Successfully created a new Manager profile!")
        return newManager
    }
    
    public func assignEmployeeToDepartment(pesel: String, departmentTitle: String) {
        guard let employee = employeeService.getEmployee(pesel: pesel) else {
            print("Error: Employee not found.")
            return
        }
        
        let allDepartments = departmentRepository.fetchAll()
        guard let department = allDepartments.first(where: { $0.title == departmentTitle }) else {
            print("Error: Department '\(departmentTitle)' does not exist.")
            return
        }
        
        employee.department = department
        
        departmentRepository.saveChanges()
        print("Successfully assigned \(employee.person.firstName) to \(departmentTitle).")
    }
    
    
    public func addCertificate(pesel: String, certificate: String) {
        guard let employee = employeeService.getEmployee(pesel: pesel) else {
            print("No employee with this pesel")
            return
        }
        
        guard let manager = employee as? Manager else {
            print("Error: This employee is not a Manager. Cannot add certificates.")
            return
        }
        
        manager.certificates.append(certificate)
        employeeService.saveChanges()
        print("Certificate '\(certificate)' successfully added to Manager's resume.")
    }
}
