//
//  DetailRow.swift
//  HotelManagementSystem
//
//  Created by Шермат Эшеров on 7/6/26.
//

import SwiftUI

struct DetailRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.gray)
            Spacer()
            Text(value)
                .bold()
        }
        .padding(.vertical, 4)
    }
}
