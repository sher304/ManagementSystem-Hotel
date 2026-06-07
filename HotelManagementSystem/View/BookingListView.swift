//
//  BookingListView.swift
//  HotelManagementSystem
//
//  Created by Шермат Эшеров on 7/6/26.
//

import SwiftUI
import SwiftData

struct BookingListView: View {
    @State private var viewModel: BookingListViewModel
    var reservations: [Reservation]
    var receptionistViewModel: ReceptionistViewModel
    
    init(context: ModelContext, reservations: [Reservation], receptionistViewModel: ReceptionistViewModel) {
        _viewModel = State(initialValue: BookingListViewModel(context: context))
        self.reservations = reservations
        self.receptionistViewModel = receptionistViewModel
    }

    var body: some View {
        List {
            ForEach(reservations) { reservation in
                NavigationLink(destination: BookingDetailView(
                    receptionistViewModel: receptionistViewModel,
                    bookingViewModel: viewModel,
                    reservation: reservation
                )) {
                    HStack(alignment: .top, spacing: 12) {
                        
                        if let imageName = reservation.room?.imageName {
                            Image(imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 100)
                                .cornerRadius(10)
                                .clipped()
                        } else {
                            ZStack {
                                Color(.systemGray5)
                                Image(systemName: "bed.double.fill")
                                    .foregroundColor(.gray)
                            }
                            .frame(width: 80, height: 100)
                            .cornerRadius(10)
                        }
                        
                        VStack(alignment: .leading, spacing: 6) {
                            HStack {
                                Text("Room \(reservation.room?.number ?? 0)")
                                    .font(.headline)
                                Spacer()
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                    .font(.caption)
                                Text(String(format: "%.1f", reservation.room?.hotel.starRating ?? 0.0))
                                    .font(.caption)
                                    .bold()
                            }
                            
                            Text(reservation.room?.hotel.address ?? "No address")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            Text("PLN \(viewModel.calculatePrice(reservation: reservation), specifier: "%.2f")")
                                .font(.subheadline)
                                .bold()
                                .foregroundColor(.blue)
                            
                            HStack {
                                Image(systemName: "calendar")
                                    .foregroundColor(.gray)
                                    .font(.caption2)
                                Text(viewModel.calculateTotalDays(reservation: reservation))
                                    .font(.caption2)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("My Booking")
        .navigationBarTitleDisplayMode(.inline)
    }
}
