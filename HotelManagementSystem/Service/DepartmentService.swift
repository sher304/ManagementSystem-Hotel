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

    // TODO: Complete METHODS
    public func getStaffCount() -> Int {
        return 1
    }
    
    public func updateBudget(value: Double) {
        
    }
    
    public func endSeason() -> Bool {
        return true
    }
}
