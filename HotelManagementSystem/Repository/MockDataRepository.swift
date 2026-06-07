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
    private let employeeService: EmployeeService
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
        self.employeeService = EmployeeService(context: context)
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
            address: "Marszalkowska 1, Warsaw",
            capacity: 500,
            totalFloors: 10,
            starRating: 5.0,
            checkOutTime: Date(),
            checkInTime: Date(),
            description: "Luxury hotel",
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
        
        let annaPerson = personService.createPerson(pesel: "190", firstName: "Anna", lastName: "Nora", phoneNumber: "555-0100", email: "anna@hotel.pl", dateOfBirth: dateOfBirth, password: "1")
        
        let bobPerson = personService.createPerson(pesel: "191", firstName: "Bob", lastName: "Kowalski", phoneNumber: "555-0101", email: "bob@hotel.pl", dateOfBirth: dateOfBirth, password: "2")
        
        let mariaPerson = personService.createPerson(pesel: "192", firstName: "Maria", lastName: "Obart", phoneNumber: "555-0102", email: "maria@hotel.pl", dateOfBirth: dateOfBirth, password: "3")
        
        let johnPerson = personService.createPerson(pesel: "193", firstName: "John", lastName: "Obart", phoneNumber: "555-0102", email: "maria@hotel.pl", dateOfBirth: dateOfBirth, password: "3")
        
        let porkPerson = personService.createPerson(pesel: "194", firstName: "Sam", lastName: "Obart", phoneNumber: "555-0102", email: "maria@hotel.pl", dateOfBirth: dateOfBirth, password: "3")
        
        let bananaPerson = personService.createPerson(pesel: "195", firstName: "Lia", lastName: "Obart", phoneNumber: "555-0102", email: "maria@hotel.pl", dateOfBirth: dateOfBirth, password: "3")
        
        let orangePerson = personService.createPerson(pesel: "196", firstName: "Mia", lastName: "Obart", phoneNumber: "555-0102", email: "maria@hotel.pl", dateOfBirth: dateOfBirth, password: "3")
        
        let bluePerson = personService.createPerson(pesel: "197", firstName: "Fia", lastName: "Obart", phoneNumber: "555-0102", email: "maria@hotel.pl", dateOfBirth: dateOfBirth, password: "3")
        
        let greenPerson = personService.createPerson(pesel: "198", firstName: "Toyota", lastName: "Obart", phoneNumber: "555-0102", email: "maria@hotel.pl", dateOfBirth: dateOfBirth, password: "3")
        
        let purplePerson = personService.createPerson(pesel: "199", firstName: "Kacepr", lastName: "Obart", phoneNumber: "555-0102", email: "maria@hotel.pl", dateOfBirth: dateOfBirth, password: "3")
        
        let brownManager = managerService.createManager(pesel: "180", baseMinimumSalary: 8000.0, hireDate: hireDate, languages: ["Polish", "English", "German"], certificates: ["MBA", "Hospitality Management"])
        
        _ = employeeService.createEmployee(pesel: "193", hireDate: hireDate, languages: ["Polish", "English", "German"])
        _ = employeeService.createEmployee(pesel: "194", hireDate: hireDate, languages: ["Polish", "English", "German"])
        _ = employeeService.createEmployee(pesel: "195", hireDate: hireDate, languages: ["Polish", "English", "German"])
        _ = employeeService.createEmployee(pesel: "196", hireDate: hireDate, languages: ["Polish", "English", "German"])
        _ = employeeService.createEmployee(pesel: "197", hireDate: hireDate, languages: ["Polish", "English", "German"])
        _ = employeeService.createEmployee(pesel: "198", hireDate: hireDate, languages: ["Polish", "English", "German"])
        _ = employeeService.createEmployee(pesel: "199", hireDate: hireDate, languages: ["Polish", "English", "German"])
        
        let bobReceptionist = receptionistService.createReceptionist(pesel: "191", hireDate: hireDate, deskNumber: 1, baseMinimumSalary: 4500.0, languages: ["Polish", "English"])
        
        let mariaHousekeeper = housekeeperService.createHouseKeeper(pesel: "192", assignedFloor: 2, hireDate: hireDate, languages: ["Polish", "Ukrainian"])
        
        managerService.assignEmployeeToDepartment(pesel: "190", departmentTitle: "Management")
        managerService.assignEmployeeToDepartment(pesel: "191", departmentTitle: "Front Desk")
        managerService.assignEmployeeToDepartment(pesel: "192", departmentTitle: "Housekeeping")
        
        if let nightWatch = securityService.createSecurity(groupAmount: 4, postLocation: "Main Lobby", shiftStart: Date(), shiftEnd: Date(), description: "Night Shift Patrol", phoneNumber: "800-999-1111") {
            hotelService.addSecurity(hotel: grandHotel, security: nightWatch)
        }
        
        let tomaszPerson = personService.createPerson(pesel: "205", firstName: "Robert", lastName: "Lewandowski", phoneNumber: "555-0200", email: "robert@gmail.pl", dateOfBirth: dateOfBirth, password: "202")
        
        guard let customer = customerService.createCustomer(pesel: "193") else { return }
        
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
