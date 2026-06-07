//
//  BaseRepository.swift
//  HotelManagementSystem
//
//  Created by Шермат Эшеров on 4/6/26.
//

import Foundation
import SwiftData

class BaseRepository<T: PersistentModel> {
    
    private var context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func add(_ item: T) {
        context.insert(item)
//        saveChanges()
    }
    
    func fetchAll() -> [T] {
        let descriptor = FetchDescriptor<T>()
        do {
            return try context.fetch(descriptor)
        } catch {
            print("Failed to fetch records: \(error)")
            return []
        }
    }
    
    func delete(_ item: T) {
        context.delete(item)
        saveChanges()
    }
    
    func saveChanges() {
        do {
            try context.save()
        } catch {
            print("Database save failed: \(error)")
        }
    }
}
