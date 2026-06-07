//
//  HouseKeeperService.swift
//  HotelManagementSystem
//
//  Created by Шермат Эшеров on 3/6/26.
//

import Foundation
import SwiftData

class HouseKeeperService {
    private let houseKeeperRepository: BaseRepository<Housekeeper>
    private let roomService: RoomService
    private let personService: PersonService
    private let epmloyeeService: EmployeeService
    
    init(context: ModelContext) {
        self.houseKeeperRepository = BaseRepository<Housekeeper>(context: context)
        self.personService = PersonService(context: context)
        self.epmloyeeService = EmployeeService(context: context)
        self.roomService = RoomService(context: context)
    }
    
    public func createHouseKeeper(pesel: String, assignedFloor: Int, hireDate: Date, languages: [String]) -> Housekeeper? {
        guard let person = personService.getPerson(pesel: pesel) else {
            print("No person with this PESEL")
            return nil
        }
        
        if person.employee != nil {
            print("This person is already employed here!")
            return person.employee as? Housekeeper
        }
        
        var houseKeeper = Housekeeper(assignedFloor: assignedFloor, hireDate: hireDate,
                                      languages: languages, person: person)

        houseKeeperRepository.add(houseKeeper)
        personService.setEmployeeRole(pesel: pesel, employee: houseKeeper)
        print("Housekeepr created")
        return houseKeeper
    }
    
    public func cleanRoom(roomNumber: Int) {
        guard let room = roomService.getRoom(roomNumber: roomNumber) else {
            print("No room found wiht this room number")
            return
        }
        
        roomService.makeAvailable(room: room)
        roomService.updateCleanDate(room: room)
        print("Room \(roomNumber) has been marked as clean and is ready for guests.")
    }
}
