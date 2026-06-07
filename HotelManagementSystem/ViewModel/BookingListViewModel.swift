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
    private let paymentService: PaymentService
    
    init(context: ModelContext) {
        self.reservationService = ReservationService(context: context)
        self.paymentService = PaymentService(context: context)
    }
    
    func calculatePrice(reservation: Reservation) -> Double {
        return reservationService.totalPrice(reservation: reservation)
    }
    
    func calculateTotalDays(reservation: Reservation) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.calendar = Calendar.current
        formatter.dateFormat = "d MMM"
        let start = formatter.string(from: reservation.checkInDate)
        formatter.dateFormat = "d MMM yyyy"
        let end = formatter.string(from: reservation.checkOutDate)
        return "\(start) - \(end)"
    }
    
    func getPaymentStatus(for reservation: Reservation) -> PaymentStatus {
        let totalPaid = reservation.payment.reduce(0) { $0 + $1.paymentAmount }
        let totalDue = reservationService.totalPrice(reservation: reservation)
        
        if totalPaid <= 0 {
            return .pending
        } else if totalPaid < totalDue {
            return .partial
        } else {
            return .paid
        }
    }
}
