//
//  InventoryService.swift
//  HotelManagementSystem
//
//  Created by Шермат Эшеров on 3/6/26.
//

import Foundation
import SwiftData

class InventoryService {
    
    private let repository: BaseRepository<Inventory>
    private let employeeService: EmployeeService
    
    init(context: ModelContext) {
        self.repository = BaseRepository<Inventory>(context: context)
        self.employeeService = EmployeeService(context: context)
    }
    
    public func createAndAssignItem(itemName: String, pesel: String) -> Inventory? {
        guard let employee = employeeService.getEmployee(pesel: pesel) else {
            print("Error: Cannot assign item. Employee not found.")
            return nil
        }
        
        let newItem = Inventory(title: itemName, employee: employee)
        repository.add(newItem)
        print("Successfully assigned \(itemName) to employee.")
        return newItem
    }
    
    public func getInventory(pesel: String) -> [Inventory] {
        guard let employee = employeeService.getEmployee(pesel: pesel) else {
            print("Employee not found.")
            return []
        }
        return employee.employeeItems
    }

    public func assignToEmp(item: Inventory, pesel: String) {
        guard let newEmployee = employeeService.getEmployee(pesel: pesel) else {
            print("Error: New employee not found.")
            return
        }
        
        item.employee = newEmployee;
        repository.saveChanges()
        print("\(item.title) reassigned successfully.")
    }
}
