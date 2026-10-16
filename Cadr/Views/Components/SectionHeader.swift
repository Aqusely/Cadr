//
//  SectionHeader.swift
//  Cadr
//
//  Created by Наливайко Кирилл on 17.10.2026.
//

import SwiftUI

struct SectionHeader: View{
    let title: String
    let action: (() -> Void)?
    
    var body: some View {
        HStack{
            Text(title)
                .foregroundStyle(Color.textPrimary)
                .font(.system(.title3, design: .rounded, weight: .bold))
            Spacer()
            if let action = action {
                Button(action:{
                    action()
                }){
                    Text("Все")
                        .foregroundStyle(Color.textSecondary)
                        .font(.footnote.weight(.medium))
                }
            }
        }
    }
}

#Preview("Сейчас популярно") {
    SectionHeader(title: "Сейчас популярно", action: {
        print("button tapped")
    })
}
