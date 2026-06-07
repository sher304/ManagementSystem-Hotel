//
//  ManagerDashboardView.swift
//  HotelManagementSystem
//
//  Created by Шермат Эшеров on 7/6/26.
//

import SwiftUI
import SwiftData

struct ManagerDashboardView: View {
    @Environment(\.modelContext) private var context
    @State private var viewModel: ManagerDashboardViewModel
    
    @Query private var employees: [Employee]
    @Query(sort: \Department.title) private var departments: [Department]
    
    init(context: ModelContext) {
        _viewModel = State(initialValue: ManagerDashboardViewModel(context: context))
    }
    
    var body: some View {
        NavigationStack {
            List(employees) { employee in
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(employee.person?.firstName ?? "Unknown")
                            .font(.headline)
                        Text("PESEL: \(employee.person?.pesel ?? "—")")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
            
                    Spacer()
                    
                    @Bindable var boundEmployee = employee
                    
                    Picker("Department", selection: $boundEmployee.department) {
                        Text("Unassigned").tag(Optional<Department>.none)
                        
                        ForEach(departments) { department in
                            let count = viewModel.getStaffCount(for: department)
                            Text("\(department.title) (\(count) staff)")
                                .tag(Optional(department))
                        }
                    }
                    .pickerStyle(.menu)
                    .tint(.blue)
                }
                .padding(.vertical, 8)
            }
            .navigationTitle("Employees")
        }
    }
}
