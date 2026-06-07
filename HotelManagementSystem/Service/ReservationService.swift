//
//  ReservationService.swift
//  HotelManagementSystem
//
//  Created by Шермат Эшеров on 3/6/26.
//

import Foundation
import SwiftData

class ReservationService {

    private let repository: BaseRepository<Reservation>
    private let roomService: RoomService
    
    init(context: ModelContext) {
        self.repository = BaseRepository<Reservation>(context: context)
        self.roomService = RoomService(context: context)
    }
    
    public func createReservation(customer: Customer, room: Room,
                                  checkIn: Date, checkOut: Date,
                                  cancelReason: String?) -> Reservation? {
        if !roomService.isAvailable(room: room, startDate: checkIn, endDate: checkOut) {
            print("Error: Room \(room.number) is completely booked for those dates.")
            return nil
        }
        
        let newReservation = Reservation(isCancelled: false, checkInDate: checkIn, checkOutDate: checkOut, cancelReason: cancelReason, room: room, customer: customer)
        repository.add(newReservation)
        print("Reservation successfully created for Room \(room.number).")
        return newReservation
    }

    public func confirmCheckIn(reservation: Reservation) {
        reservation.room?.status = .booked
        repository.saveChanges()
        print("Check-in confirmed for Room \(reservation.room?.number).")
    }
    
    public func checkOut(reservation: Reservation) {
        reservation.room?.status = .cleaning
        repository.saveChanges()
        print("Check-out complete. Room \(reservation.room?.number) now requires cleaning.")
    }
    
    public func cancel(reservation: Reservation) {
        reservation.room?.status = .free
        repository.delete(reservation)
        print("Reservation has been cancelled and the room is free.")
    }
    
    public func isFullPaid(reservation: Reservation) -> Bool {
        let totalCost: Double = totalPrice(reservation: reservation)
        let nonRefundedPayments: [Payment] = reservation.payment.filter { $0.status != .refunded }
        let totalPaid: Double = nonRefundedPayments.reduce(0.0) { (sum: Double, payment: Payment) -> Double in
            return sum + payment.paymentAmount
        }
        return totalPaid >= totalCost
    }
    
    public func totalPrice(reservation: Reservation) -> Double {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: reservation.checkInDate, to: reservation.checkOutDate)
        let nights = max(1, components.day ?? 1)
        let basePrice = 150.0
        
        return basePrice * Double(nights)
    }
}

