//
//  BookingListViewModel.swift
//  HotelManagementSystem
//
//  Created by Шермат Эшеров on 7/6/26.
//

import Foundation
import SwiftData

@Observable
class BookingListViewModel {
    private let reservationService: ReservationService
    
    init(context: ModelContext) {
        self.reservationService = ReservationService(context: context)
    }
    
    func calculatePrice(reservation: Reservation) -> Double {
        return reservationService.totalPrice(reservation: reservation)
    }
}
