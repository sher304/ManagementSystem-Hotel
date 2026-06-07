//
//  SearchCustomerView.swift
//  HotelManagementSystem
//
//  Created by Шермат Эшеров on 7/6/26.
//

import SwiftUI
import SwiftData

struct SearchCustomerView: View {
    @Environment(\.modelContext) private var context
    
    @State private var viewModel: ReceptionistViewModel
    
    init(context: ModelContext) {
        _viewModel = State(initialValue: ReceptionistViewModel(context: context))
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                
                Text("PESEL")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                
                TextField("040423123312", text: $viewModel.searchPesel)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .keyboardType(.numberPad)
   
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                        .transition(.opacity)
                }
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        viewModel.searchForCustomer()
                    }
                }) {
                    Text("Search")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
            .navigationTitle("Search Customer")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $viewModel.navigateToResults) {
                BookingListView(
                        context: context,
                        reservations: viewModel.activeReservations,
                        receptionistViewModel: viewModel
                    )
            }
        }
    }
}
