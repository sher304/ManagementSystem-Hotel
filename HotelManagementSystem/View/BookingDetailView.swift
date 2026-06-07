//
//  BookingDetailView.swift
//  HotelManagementSystem
//
//  Created by Шермат Эшеров on 7/6/26.
//

import SwiftUI

struct BookingDetailView: View {
    var receptionistViewModel: ReceptionistViewModel
    var bookingViewModel: BookingListViewModel
    var reservation: Reservation
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                HStack(spacing: 15) {
                    if let imageName = reservation.room?.imageName {
                        Image(imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .cornerRadius(10)
                            .clipped()
                    } else {
                        Rectangle()
                            .fill(Color(.systemGray5))
                            .frame(width: 80, height: 80)
                            .cornerRadius(10)
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Room \(reservation.room?.number ?? 0)")
                            .font(.title3).bold()
                        HStack {
                            Image(systemName: "star.fill").foregroundColor(.yellow).font(.caption)
                            Text("4.7").bold()
                        }
                        Text(reservation.room?.hotel.address ?? "Warsaw, Poland")
                            .font(.caption).foregroundColor(.gray)
                        Text("PLN \(bookingViewModel.calculatePrice(reservation: reservation), specifier: "%.2f")/night")
                            .foregroundColor(.blue).bold()
                    }
                    Spacer()
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(15)
                .shadow(radius: 2)
                
                VStack(spacing: 15) {
                    DetailRow(title: "Dates", value: bookingViewModel.calculateTotalDays(reservation: reservation))
                    DetailRow(title: "Guest", value: "\(reservation.room?.capacity ?? 0) Guests")
                    DetailRow(title: "Paid", value: bookingViewModel.getPaymentStatus(for: reservation).rawValue)
                    DetailRow(title: "Room status", value: reservation.room?.status.rawValue ?? "Unknown")
                }
                .padding()
                
                Button(action: {
                    receptionistViewModel.confirmCheckIn(reservation: reservation)
                }) {
                    Text("Confirm Check In")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(receptionistViewModel.checkConfirmCheckIn(reservation: reservation) ? Color.green : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(!receptionistViewModel.checkConfirmCheckIn(reservation: reservation))
                
                Button(action: { }) {
                    Text("Customer under 18")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        .navigationTitle("Booking Detail")
    }
}
