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
        VStack{
            HStack{
                Image(systemName: "star.fill")
                Text(String(voteAverage))
            }
        }
        .padding(4)
        .background(Color.green, in: RoundedRectangle(cornerRadius: 16))
        .font(.system(size: 13))
    }
}

#Preview {
    RatingBadge(voteAverage: 5.4)
}
