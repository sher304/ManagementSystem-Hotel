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
    
    var searchPesel: String = ""
    var foundCustomer: Customer? = nil
    var activeReservations: [Reservation] = []
    var errorMessage: String? = nil
        
    var navigateToResults: Bool = false
    
    init(context: ModelContext) {
        self.customerService = CustomerService(context: context)
        self.reservationService = ReservationService(context: context)
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
    
    func confirmCheckIn(reservation: Reservation) {
        reservationService.confirmCheckIn(reservation: reservation)
    }
    
    func calculatePrice(for reservation: Reservation) -> Double {
        return reservationService.totalPrice(reservation: reservation)
    }
}
