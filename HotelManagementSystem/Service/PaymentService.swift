//
//  PaymentService.swift
//  HotelManagementSystem
//
//  Created by Шермат Эшеров on 3/6/26.
//

import Foundation
import SwiftData


class PaymentService {
    
    private let repository: BaseRepository<Payment>
        
    init(context: ModelContext) {
        self.repository = BaseRepository<Payment>(context: context)
    }
    
    @discardableResult
    public func makeFullPayment(reservation: Reservation, amount: Double, method: String) -> Payment {
        let payment = Payment(date: Date(),
                              status: .paid, paymentType: method,
                              paymentAmount: amount,
                              reservation: reservation)
        repository.add(payment)
        print("Full payment of pln\(amount) processed via \(method).")
        return payment
    }
    
    @discardableResult
    public func makePartialPayment(reservation: Reservation, amount: Double, method: String) -> Payment {
        let payment = Payment(date: Date(),
                              status: .pending, paymentType: method,
                              paymentAmount: amount,
                              reservation: reservation)
        repository.add(payment)
        print("Partial payment of pln\(amount) processed via \(method).")
        return payment
    }
    
    public func makeRefund(payment: Payment) {
        if payment.status == .refunded {
            print("Error: This payment has already been refunded.")
            return
        }
        
        payment.status = .refunded
        repository.saveChanges()
        print("Refund of $\(payment.paymentAmount) has been successfully issued.")
    }
}
