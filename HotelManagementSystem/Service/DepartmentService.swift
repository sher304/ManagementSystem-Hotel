//
//  DepartmentService.swift
//  HotelManagementSystem
//
//  Created by Шермат Эшеров on 3/6/26.
//

import Foundation
import SwiftData

class DepartmentService {
    
    private let repository: BaseRepository<Department>
    private let employeeService: EmployeeService
    
    init(context: ModelContext) {
        self.repository = BaseRepository<Department>(context: context)
        self.employeeService = EmployeeService(context: context)
    }
    
    public func createDepartment(title: String, floor: Int, budget: Double) -> Department? {
        if getDepartment(title: title) != nil {
            print("Department '\(title)' already exists.")
            return nil
        }
        let newDepartment = Department(title: title, floor: floor, budget: budget)
        repository.add(newDepartment)
        print("Successfully created the \(title) department on floor \(floor).")
        return newDepartment
    }
    
    public func getDepartment(title: String) -> Department? {
        return repository.fetchAll().first { $0.title == title }
    }
    
    public func getAllDepartments() -> [Department] {
        return repository.fetchAll()
    }

    public func getStaffCount(department: Department) -> Int {
        return department.employees.count
    }
    
    public func updateBudget(department: Department, newBudget: Double) {
        department.budget = newBudget
        repository.saveChanges()
        print("\(department.title) budget successfully updated to \(newBudget).")
    }
    
    public func endSeason(for department: Department) -> Bool {
        department.budget = 0.0
        repository.saveChanges()
        print("Season ended for \(department.title). Budget reset.")
        return true
    }
}
