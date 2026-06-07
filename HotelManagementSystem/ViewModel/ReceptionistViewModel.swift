//
//  ReservationViewModel.swift
//  HotelManagementSystem
//
//  Created by Шермат Эшеров on 3/6/26.
//

import SwiftUI
import SwiftData

@Observable
class ReceptionistViewModel {
    private let customerService: CustomerService
    private let reservationService: ReservationService
    private let receptionistService: ReceptioinistService
    
    var searchPesel: String = ""
    var foundCustomer: Customer? = nil
    var activeReservations: [Reservation] = []
    var errorMessage: String? = nil
        
    var navigateToResults: Bool = false
    
    init(context: ModelContext) {
        self.customerService = CustomerService(context: context)
        self.reservationService = ReservationService(context: context)
        self.receptionistService = ReceptioinistService(context: context)
    }
    
    func searchForCustomer() {
        self.errorMessage = nil
        self.navigateToResults = false
        
        guard let customer = customerService.getCustomer(pesel: searchPesel) else {
            self.errorMessage = "No customer found with PESEL: \(searchPesel)"
            return
        }
        
        if customer.reservation.isEmpty {
            self.errorMessage = "No reservation found for this client"
            return
        }
        self.foundCustomer = customer
        self.activeReservations = customer.reservation
        self.navigateToResults = true
    }
    
    func checkConfirmCheckIn(reservation: Reservation) -> Bool {
        let isRoomReady = reservation.room?.status == .free || reservation.room?.status == .booked
        let customer = reservation.customer.person.dateOfBirth
        let isAdult = receptionistService.calculateAge(customer: reservation.customer) >= 18
        let isPaid = reservationService.isFullPaid(reservation: reservation)
        return isRoomReady && isAdult && isPaid
    }
    
    func confirmCheckIn(reservation: Reservation) {
        if checkConfirmCheckIn(reservation: reservation) {
            reservationService.confirmCheckIn(reservation: reservation)
            print("Check-in confirmed for Room \(reservation.room?.number ?? 0)")
        }
    }
    
    func calculatePrice(for reservation: Reservation) -> Double {
        return reservationService.totalPrice(reservation: reservation)
    }
}
