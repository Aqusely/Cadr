//
//  GenreChip.swift
//  Cadr
//
//  Created by Наливайко Кирилл on 16.10.2026.
//

import SwiftUI

struct GenreChip: View {
    let name: String
    let isSelected: Bool
    
    var body: some View{
        Text(name)
            .font(.footnote.weight(.medium))
            .foregroundStyle(isSelected ? Color.white : Color.textSecondary)
            .padding(.horizontal,12)
            .padding(.vertical, 6)
            .background(isSelected ? Color.accent : Color.surface, in: Capsule())
            .overlay{
                if !isSelected{
                    Capsule().strokeBorder(Color.line, lineWidth: 1)
                }
            }
    }
}

#Preview {
    GenreChip(name: "Боевик", isSelected: false)
}
#Preview {
    GenreChip(name: "Боевик и фэнтази жанры", isSelected: true)
}
