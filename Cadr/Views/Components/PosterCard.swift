//
//  PosterCard.swift
//  Cadr
//
//  Created by Наливайко Кирилл on 17.10.2026.
//

import SwiftUI

struct noView: View{
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 12).fill(Color.surface)
            Image(systemName: "film")
                .foregroundStyle(Color.textSecondary)
                .font(.system(size: 28))
        }
    }
}

struct PosterCard: View{
    let movie: Movie
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8){
            ZStack(alignment: .topTrailing){
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
                }else {
                    noView()
                }
                RatingBadge(voteAverage: movie.voteAverage)
                    .padding(6)
            }
                .aspectRatio(2/3, contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            VStack(alignment: .leading, spacing: 4){
                Text(movie.title)
                    .foregroundStyle(Color.textPrimary)
                    .font(.subheadline.weight(.semibold))
                    .lineLimit(2, reservesSpace: true)
                Text(movie.releaseDate?.prefix(4) ?? "")
                    .foregroundStyle(Color.textSecondary)
                    .font(.footnote)
            }
        }
        .frame(width: 120)
    }
}

#Preview {
    PosterCard(movie: Movie(
        id: 62104,
        title: "Дюна",
        voteAverage: 8.4,
        releaseDate: "2021-02-10",
        backdropPath: nil,
        posterPath: "/cCovtlN16ykvyFYnzKyv3dFtceG.jpg"))
}
