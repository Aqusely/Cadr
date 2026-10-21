//
//  MovieRow.swift
//  Cadr
//
//  Created by Наливайко Кирилл on 17.10.2026.
//

import SwiftUI

struct MovieRow: View{
    let movie: Movie
    
    var body: some View {
        HStack(spacing: 12){
            PosterImage(url: ImagePath.imageURL(imagePath: movie.posterPath, size: .small), cornerRadius: 8)
                .frame(width: 53)
            VStack(alignment: .leading){
                Text(movie.title)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(Color.textPrimary)
                    .lineLimit(2)
                Text((movie.releaseDate?.prefix(4) ?? ""))
                    .font(.footnote)
                    .foregroundStyle(Color.textSecondary)
            }
            Spacer()
            RatingBadge(voteAverage: movie.voteAverage)
        }
        .frame(height: 80)
        .frame(maxWidth: .infinity)
        .padding(.bottom, 12)
    }
}

#Preview {
    MovieRow(movie: Movie(
        id: 62104,
        title: "Дюна",
        voteAverage: 8.4,
        releaseDate: "2021-02-10",
        backdropPath: nil,
        posterPath: "/cCovtlN16ykvyFYnzKyv3dFtceG.jpg"
    ))
}
