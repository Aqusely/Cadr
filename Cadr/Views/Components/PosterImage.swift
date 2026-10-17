//
//  PosterImage.swift
//  Cadr
//
//  Created by Наливайко Кирилл on 17.10.2026.
//

import SwiftUI

struct PosterImage: View{
    let movie: Movie
    
    var body: some View{
        if movie.posterPath != nil {
            AsyncImage(url: ImagePath.imageURL(imagePath: movie.posterPath, size: .small)) { phase in
                switch phase {
                case .empty:
                    ZStack{
                        RoundedRectangle(cornerRadius: 12).fill(Color.surface)
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
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }else {
            noView()
        }
    }
}
