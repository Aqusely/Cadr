//
//  RatingBadge.swift
//  Cadr
//
//  Created by Наливайко Кирилл on 16.10.2026.
//

import SwiftUI

struct RatingBadge: View {
    let voteAverage: Double
    
    var body: some View {
        HStack(spacing: 4){
            Image(systemName: "star.fill")
            Text(voteAverage != 0.0 ? String(format: "%.1f", voteAverage) : "-")
        }
        .padding(.vertical, 4)
        .padding(.horizontal, 6)
        .background(Color.background.opacity(0.75), in: RoundedRectangle(cornerRadius: 8))
        .font(.caption.weight(.semibold))
        .foregroundStyle(Color.gold)
        
    }
}

#Preview {
    RatingBadge(voteAverage: 5.4)
}
