//
//  RoomService.swift
//  HotelManagementSystem
//
//  Created by Шермат Эшеров on 3/6/26.
//

import Foundation
import SwiftData

class RoomService {
    
    private let repository: BaseRepository<Room>
    
    init(context: ModelContext) {
        self.repository = BaseRepository<Room>(context: context)
    }
    
    public func getRoom(roomNumber: Int) -> Room? {
        return repository.fetchAll().first { room in
            room.number == roomNumber
        }
    }
    
    public func createRoom(hotel: Hotel, roomNumber: Int, floor: Int, capacity: Int) -> Room? {
        if getRoom(roomNumber: roomNumber) != nil {
            print("Room \(roomNumber) already exists.")
            return nil
        }
        
        let newRoom = Room(
            number: roomNumber,
            floor: floor,
            lastCleanedDate: Date(),
            smokeAllowed: false,
            capacity: capacity,
            description: "Standard Room",
            status: .free,
            hotel: hotel
        )
        
        repository.add(newRoom)
        return newRoom
    }
    
    public func makeBooked(room: Room) {
        room.status = .booked
        repository.saveChanges()
    }
    public func markAsDirty(room: Room) {
        room.status = .cleaning
        repository.saveChanges()
    }
    public func makeAvailable(room: Room) {
        room.status = .free
        repository.saveChanges()
    }
    public func updateCleanDate(room: Room){
        room.lastCleanedDate = Date()
        repository.saveChanges()
    }
    
    public func isAvailable(room: Room, startDate: Date, endDate: Date) -> Bool {
        let hasOverlap = room.reservations.contains(where: { reservation in
            startDate < reservation.checkOutDate && endDate > reservation.checkInDate
        })
        
        return !hasOverlap
    }
    
    public func getAllRooms() -> [Room] {
        return repository.fetchAll();
    }
    
    public func updateRoom(room: Room) {
        repository.saveChanges()
    }
    
    public func removeRoom(room: Room) {
        repository.delete(room)
    }
}
