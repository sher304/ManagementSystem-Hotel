//
//  SecurityService.swift
//  HotelManagementSystem
//
//  Created by Шермат Эшеров on 3/6/26.
//

import Foundation
import SwiftData

class SecurityService {
    
    private let repository: BaseRepository<Security>
    
    init(context: ModelContext) {
        self.repository = BaseRepository<Security>(context: context)
    }
    
    public func getSecurity(phoneNumber: String) -> Security? {
        return repository.fetchAll().first { security in
            security.phoneNumber == phoneNumber
        }
    }
    
    public func createSecurity(groupAmount: Int, postLocation: String,
                               shiftStart: Date, shiftEnd: Date,
                               description: String, phoneNumber: String) -> Security? {
        if getSecurity(phoneNumber: phoneNumber) != nil {
            print("Security with this phone number is already exists")
            return nil
        }
            
        let security = Security(groupAmount: groupAmount, postLocation: postLocation, shiftStart: shiftStart, shiftEnd: shiftEnd, description: description, phoneNumber: phoneNumber)
        repository.add(security)
        return security
    }
    
    public func logIncident(security: Security, report: String) {
        print("Incident logged for team at \(security.postLocation): \(report)")
    }
    
    public func getShiftDuration(security: Security) -> TimeInterval {
        return security.shiftEnd.timeIntervalSince(security.shiftStart)
    }
    
    private func respondIncident(security: Security) {
        print("Security team \(security.phoneNumber) is responding.")
    }
    
    public func updateSecurity(security: Security) {
        repository.saveChanges()
    }
    
    public func removeSecurity(security: Security) {
        repository.delete(security)
    }
}
