//
//  FacilityService.swift
//  HotelManagementSystem
//
//  Created by Шермат Эшеров on 3/6/26.
//

import Foundation
import SwiftData

class FacilityService {
    
    private let repository: BaseRepository<Facility>
        
    init(context: ModelContext) {
        self.repository = BaseRepository<Facility>(context: context)
    }
    
    public func createFacility(title: String, maximumCapacity: Int,
                               openingHours: Date, dept: Department) -> Facility? {
        let newFacility = Facility(title: title, maxCapacity: maximumCapacity,
                                   openingHours: openingHours, department: dept)
        repository.add(newFacility)
        print("Successfully created the \(title) facility.")
        return newFacility
    }
    
    public func getAllFacilities() -> [Facility] {
            return repository.fetchAll()
    }
    
    // TODO: Complete methods
    public func getCurrentCapacity() -> Int {
        return 0
    }
    public func closeFacility(facility: Facility) -> Bool {
        repository.saveChanges()
        print("\(facility.title) has been closed.")
        return true
    }
    public func updateOpeningHours(facility: Facility, time: Date) {
        repository.saveChanges()
        print("Operating hours for \(facility.title) have been updated.")
    }
}
