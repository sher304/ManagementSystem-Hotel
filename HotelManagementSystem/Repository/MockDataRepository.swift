//
//  MockDataRepository.swift
//  HotelManagementSystem
//
//  Created by Шермат Эшеров on 4/6/26.
//

import Foundation
import SwiftData

class MockDataRepository {
    private let hotelService: HotelService
    private let roomService: RoomService
    private let departmentService: DepartmentService
    private let facilityService: FacilityService
    private let personService: PersonService
    private let managerService: ManagerService
    private let receptionistService: ReceptioinistService
    private let housekeeperService: HouseKeeperService
    private let customerService: CustomerService
    private let reservationService: ReservationService
    private let paymentService: PaymentService
    private let securityService: SecurityService
    private var context: ModelContext
    
    init(context: ModelContext) {
        self.hotelService = HotelService(context: context)
        self.roomService = RoomService(context: context)
        self.departmentService = DepartmentService(context: context)
        self.facilityService = FacilityService(context: context)
        self.personService = PersonService(context: context)
        self.managerService = ManagerService(context: context)
        self.receptionistService = ReceptioinistService(context: context)
        self.housekeeperService = HouseKeeperService(context: context)
        self.customerService = CustomerService(context: context)
        self.reservationService = ReservationService(context: context)
        self.paymentService = PaymentService(context: context)
        self.securityService = SecurityService(context: context)
        self.context = context
    }
    
    public func seedDatabase() {
        if !hotelService.getAllHotels().isEmpty {
            print("Database is already seeded. Skipping mock data generation.")
            return
        }
        
        print("--- STARTING DATABASE SEED ---")
        
        guard let grandHotel = hotelService.createHotel(
            title: "Grand Warsaw Hotel",
            address: "Marszałkowska 1, Warsaw",
            capacity: 500,
            totalFloors: 10,
            starRating: 5.0,
            checkOutTime: Date(),
            checkInTime: Date(),
            description: "Luxury hotel in the heart of the city.",
            maximumCapacity: 1000,
            firstRoomNumber: 101,
            firstRoomCapacity: 2
        ) else { return }
        
        hotelService.createNewRoom(hotel: grandHotel, roomNumber: 102, floor: 1,
                                   capacity: 2, imageName: "room6")
        let room201 = hotelService.createNewRoom(hotel: grandHotel, roomNumber: 201,
                                                 floor: 2, capacity: 4, imageName: "room1")
        let room202 = hotelService.createNewRoom(hotel: grandHotel, roomNumber: 202,
                                                 floor: 3, capacity: 4, imageName: "room2")
        let room203 = hotelService.createNewRoom(hotel: grandHotel, roomNumber: 203,
                                                 floor: 4, capacity: 4, imageName: "room3")
        
        var managment = departmentService.createDepartment(title: "Management", floor: 10, budget: 50000.0)!
        var fronDesk = departmentService.createDepartment(title: "Front Desk", floor: 1, budget: 15000.0)!
        var houseKeeping = departmentService.createDepartment(title: "Housekeeping", floor: -1, budget: 20000.0)!
        
        _ = facilityService.createFacility(title: "Pool", maximumCapacity: 120, openingHours: Date(), dept: managment)
        _ = facilityService.createFacility(title: "BellBoy", maximumCapacity: 120, openingHours: Date(), dept: fronDesk)
        _ = facilityService.createFacility(title: "House party", maximumCapacity: 120, openingHours: Date(), dept: houseKeeping)
        
        let dateOfBirth = Calendar.current.date(byAdding: .year, value: -30, to: Date()) ?? Date()
        let hireDate = Calendar.current.date(byAdding: .month, value: -6, to: Date()) ?? Date()
        
        _ = personService.createPerson(pesel: "90051412345", firstName: "Anna", lastName: "Nowak", phoneNumber: "555-0100", email: "anna@hotel.pl", dateOfBirth: dateOfBirth)
        _ = personService.createPerson(pesel: "95082154321", firstName: "Jan", lastName: "Kowalski", phoneNumber: "555-0101", email: "jan@hotel.pl", dateOfBirth: dateOfBirth)
        _ = personService.createPerson(pesel: "88010199999", firstName: "Maria", lastName: "Wisniewska", phoneNumber: "555-0102", email: "maria@hotel.pl", dateOfBirth: dateOfBirth)
        
        _ = managerService.createManager(pesel: "90051412345", baseMinimumSalary: 8000.0, hireDate: hireDate, languages: ["Polish", "English", "German"], certificates: ["MBA", "Hospitality Management"])
        _ = receptionistService.createReceptionist(pesel: "95082154321", hireDate: hireDate, deskNumber: 1, baseMinimumSalary: 4500.0, languages: ["Polish", "English"])
        _ = housekeeperService.createHouseKeeper(pesel: "88010199999", assignedFloor: 2, hireDate: hireDate, languages: ["Polish", "Ukrainian"])
        
        managerService.assignEmployeeToDepartment(pesel: "90051412345", departmentTitle: "Management")
        managerService.assignEmployeeToDepartment(pesel: "95082154321", departmentTitle: "Front Desk")
        managerService.assignEmployeeToDepartment(pesel: "88010199999", departmentTitle: "Housekeeping")
        
        if let nightWatch = securityService.createSecurity(groupAmount: 4, postLocation: "Main Lobby", shiftStart: Date(), shiftEnd: Date(), description: "Night Shift Patrol", phoneNumber: "800-999-1111") {
            hotelService.addSecurity(hotel: grandHotel, security: nightWatch)
        }
        
        _ = personService.createPerson(pesel: "99022877777", firstName: "Tomasz", lastName: "Lewandowski", phoneNumber: "555-0200", email: "tomasz@guest.pl", dateOfBirth: dateOfBirth)
        guard let customer = customerService.createCustomer(pesel: "99022877777") else { return }
        
        let checkInDate = Date()
        let checkOutDate = Calendar.current.date(byAdding: .day, value: 3, to: Date()) ?? Date()
        
        if let room = room201, let reservation = reservationService.createReservation(customer: customer, room: room, checkIn: checkInDate, checkOut: checkOutDate, cancelReason: nil) {
            
            reservationService.confirmCheckIn(reservation: reservation)
            
            let amountDue = reservationService.totalPrice(reservation: reservation)
            paymentService.makeFullPayment(reservation: reservation, amount: amountDue, method: "Credit Card")
        }
        
        print("--- DATABASE SEED COMPLETE ---")
        if let url = context.container.configurations.first?.url.path(percentEncoded: false) {
            print("DATABASE URL: \(url)")
        }
    }
}
