//
//  ManagmentViewModel.swift
//  HotelManagementSystem
//
//  Created by Шермат Эшеров on 3/6/26.
//

import Foundation
import SwiftData

@Observable
class ManagerDashboardViewModel {
    private let departmentService: DepartmentService
    
    init(context: ModelContext) {
        self.departmentService = DepartmentService(context: context)
    }
    
    func createNewDepartment(title: String, floor: Int, budget: Double) {
        let _ = departmentService.createDepartment(title: title, floor: floor, budget: budget)
    }
    
    func getStaffCount(for department: Department) -> Int {
        return departmentService.getStaffCount(department: department)
    }
    
    func updateDepartmentBudget(department: Department, newBudget: Double) {
        departmentService.updateBudget(department: department, newBudget: newBudget)
    }
    
    func endDepartmentSeason(department: Department) {
        let _ = departmentService.endSeason(for: department)
    }
}
