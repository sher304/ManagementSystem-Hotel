//
//  HotelService.swift
//  HotelManagementSystem
//
//  Created by Шермат Эшеров on 3/6/26.
//

import Foundation
import SwiftData

class HotelService {
    
    private let repository: BaseRepository<Hotel>
    private let roomService: RoomService
    private let securityService: SecurityService
        
    init(context: ModelContext) {
        self.repository = BaseRepository<Hotel>(context: context)
        self.roomService = RoomService(context: context)
        self.securityService = SecurityService(context: context)
    }

    public func getAllHotels() -> [Hotel] {
        return repository.fetchAll()
    }
    
    public func createHotel(title: String, address: String, capacity: Int,
                            totalFloors: Int, starRating: Double,
                            checkOutTime: Date, checkInTime: Date,
                            description: String, maximumCapacity: Int,
                            firstRoomNumber: Int, firstRoomCapacity: Int) -> Hotel? {
        let newHotel = Hotel.createHotel(title: title, address: address, starRating: starRating, totalFloors: totalFloors, checkInTime: checkInTime, checkOutTime: checkOutTime, maximumCapacity: maximumCapacity, description: description, roomNumber: firstRoomNumber, capacity: capacity)
        repository.add(newHotel)
        print("Successfully created hotel '\(title)' with starter Room \(firstRoomNumber).")
        return newHotel
    }
    
    public func saveChanges() {
        repository.saveChanges()
    }

    public func getAvailableRooms(checkIn: Date, checkOut: Date) -> [Room] {
        let allRooms = roomService.getAllRooms()
        
        return allRooms.filter { room in
            let hasOverlap = room.reservations.contains(where: { reservation in
                return checkIn < reservation.checkOutDate && checkOut > reservation.checkInDate
            })
            return !hasOverlap
        }
    }
    
    public func getAllRooms() -> [Room] {
        return roomService.getAllRooms()
    }

    @discardableResult
    public func createNewRoom(hotel: Hotel, roomNumber: Int, floor: Int, capacity: Int, imageName: String) -> Room? {
        return roomService.createRoom(
            hotel: hotel,
            roomNumber: roomNumber,
            floor: floor,
            capacity: capacity,
            imageName: imageName
        )
    }
    
    public func getSecurity(phoneNumber: String) -> Security? {
        return securityService.getSecurity(phoneNumber: phoneNumber)
    }
    
    public func addSecurity(hotel: Hotel, security: Security) {
        hotel.addSecurity(security)
        repository.saveChanges()
    }
    
    public func getOverallOccupancy(for hotel: Hotel) -> Int {
        let hotelRooms = hotel.rooms
        if hotelRooms.isEmpty {
            return 0
        }
        let unavailableRooms = hotelRooms.filter { $0.status != .free }.count
        return unavailableRooms
    }
}
