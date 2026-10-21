//
//  HomeView.swift
//  Cadr
//
//  Created by Наливайко Кирилл on 18.10.2026.
//

import SwiftUI

struct HomeView: View{
    
    @State private var genres: [String] = ["Боевик", "Драма", "Комедия", "Фантастика"]
    @State private var selectedGenre: Int = 0
    @State private var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel){
        _viewModel = State(initialValue: viewModel)
    }
    
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
                    switch viewModel.state {
                    case .success(let movies):
                        ScrollView(.horizontal, showsIndicators: false){
                            LazyHStack(alignment: .top, spacing: 12){
                                ForEach(movies, id: \.id) { movie in
                                    NavigationLink(value: movie){
                                        PosterCard(movie: movie)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                        .contentMargins(.horizontal, 16)
                    case .loading:
                        HStack(spacing: 12){
                            ForEach(0..<3){ _ in
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.surface)
                                    .overlay{
                                        ProgressView()
                                            .tint(Color.textPrimary)
                                    }
                                    .frame(width: 120)
                            }
                        }
                        .contentMargins(16)
                        .frame(maxWidth: .infinity)
                        .frame(height: 180)
                        
                    case .error(let error):
                        VStack{
                            Text(String(error.errorDescription ?? "Ошибка"))
                                .foregroundStyle(Color.textSecondary)
                                .font(.subheadline)
                            Button(action: {
                                Task{
                                    await viewModel.loadPopularMovies(page: 1)
                                }
                            }){
                                Text("Загрузить заново")
                                    .font(.subheadline.weight(.semibold))
                                    .foregroundStyle(.white)
                                    .padding(.horizontal, 16)
                                    .frame(minHeight: 44)
                                    .background(Color.accent, in: RoundedRectangle(cornerRadius: 12))
                            }
                            .buttonStyle(.plain)
                            
                        }
                        .padding(.top, 50)
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                
            }
            .frame(maxWidth: .infinity)
            .frame(maxHeight: .infinity, alignment: .top)
            
        }
        .task {
            await viewModel.loadPopularMovies(page: 1)
        }
    }
}
    
#Preview {
    HomeView(viewModel: HomeViewModel(movieService: MockMovieService(shouldFail: false)))
}
