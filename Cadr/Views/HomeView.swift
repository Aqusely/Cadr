//
//  HomeView.swift
//  Cadr
//
//  Created by Наливайко Кирилл on 18.10.2026.
//

import SwiftUI

struct HomeView: View{
    
    @State private var genres: [String] = ["Боевик", "Дрма", "Комедия", "Фантастика"]
    @State private var selectedGenre: Int = 0
    @State private var popularMovies: [Movie] = [
        Movie(id: 62104,title: "Дюна",voteAverage: 8.4,releaseDate:"2021-02-10",backdropPath: nil,posterPath: "/cCovtlN16ykvyFYnzKyv3dFtceG.jpg"),
        Movie(id: 62105,title: "Дюна",voteAverage: 8.4,releaseDate:"2021-02-10",backdropPath: nil,posterPath: nil),
        Movie(id: 62106,title: "Дюна",voteAverage: 8.4,releaseDate:"2021-02-10",backdropPath: nil,posterPath: "/cCovtlN16ykvyFYnzKyv3dFtceG.jpg")
    ]
    
    var body: some View{
        ZStack{
            Color.background.ignoresSafeArea()
            
            // Корневой Vstack
            VStack(alignment: .leading, spacing: 24) {
                
                // Шапка
                VStack(alignment: .leading, spacing: 4) {
                    Text("Добрый вечер")
                        .font(.footnote)
                        .foregroundStyle(Color.textSecondary)
                    Text("Что смотрим сегодня?")
                        .font(.system(.title, design: .rounded, weight: .bold))
                        .foregroundStyle(Color.textPrimary)
                }
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // Жанры
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: 8){
                        ForEach(genres.indices, id: \.self){ index in
                            Button(action:{
                                withAnimation(.snappy){
                                    self.selectedGenre = index
                                }
                            }){
                                GenreChip(name: genres[index], isSelected: selectedGenre == index)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .contentMargins(.horizontal, 16)
                
                // Сейчас популярно
                VStack(alignment: .leading, spacing: 12){
                    SectionHeader(title: "Сейчас популярно", action: {})
                        .padding(.horizontal, 16)
                    ScrollView(.horizontal, showsIndicators: false){
                        LazyHStack(alignment: .top, spacing: 12){
                            ForEach(popularMovies, id: \.id) { movie in
                                PosterCard(movie: movie)
                            }
                        }
                    }
                    .contentMargins(.horizontal, 16)
                }
                
            }
            .frame(maxWidth: .infinity)
            .frame(maxHeight: .infinity, alignment: .top)
            
        }
    }
}


#Preview {
    HomeView()
}
