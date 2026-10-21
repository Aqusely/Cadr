//
//  PosterImage.swift
//  Cadr
//
//  Created by Наливайко Кирилл on 17.10.2026.
//

import SwiftUI

struct PosterImage: View{
    let url: URL?
    let cornerRadius: CGFloat
    
    var body: some View{
        if url != nil {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ZStack{
                        RoundedRectangle(cornerRadius: cornerRadius).fill(Color.surface)
                        ProgressView()
                            .tint(Color.textSecondary)
                    }
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                case .failure(_):
                    noView()
                @unknown default:
                    EmptyView()
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        }else {
            noView()
        }
    }
}
