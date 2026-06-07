//
//  CheckInSuccessView.swift
//  HotelManagementSystem
//
//  Created by Шермат Эшеров on 7/6/26.
//

import SwiftUI

struct CheckInSuccessView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(.systemGray6))
                    .frame(width: 160, height: 180)
                
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(.systemGray5).opacity(0.5))
                    .frame(width: 130, height: 130)
                    .offset(y: 10)
                
                HStack(spacing: 12) {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 35, height: 35)
                        .foregroundColor(.green)
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Capsule()
                            .fill(Color.blue.opacity(0.8))
                            .frame(width: 80, height: 8)
                        Capsule()
                            .fill(Color.blue.opacity(0.8))
                            .frame(width: 50, height: 8)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.05), radius: 10, y: 5)
                .offset(y: 50)
            }
            .padding(.bottom, 60)
            
            Text("Check in success")
                .font(.title2)
                .bold()
                .foregroundColor(.black)
            
            Spacer()
            
            VStack(spacing: 15) {
                Button(action: {
                    dismiss()
                }) {
                    Text("View Hotel Booking")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 0.2, green: 0.3, blue: 0.7))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                
                Button(action: {
                    dismiss()
                }) {
                    Text("Close")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(Color(red: 0.2, green: 0.3, blue: 0.7))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(red: 0.2, green: 0.3, blue: 0.7), lineWidth: 1)
                        )
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 30)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.black)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { }) {
                    Image(systemName: "ellipsis")
                        .rotationEffect(.degrees(90))
                        .foregroundColor(.black)
                }
            }
        }
    }
}
