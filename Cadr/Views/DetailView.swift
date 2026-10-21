//
//  DetailView.swift
//  Cadr
//
//  Created by Наливайко Кирилл on 20.10.2026.
//

import SwiftUI

struct DetailView: View {
    
    @State private var viewModel: DetailViewModel
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View{
        ZStack{
            Color.background.ignoresSafeArea()
            switch viewModel.state{
            case .loading:
                ProgressView()
                    .tint(Color.textPrimary)
            case .success(let movieDetails):
                ScrollView{
                    // Шапка
                    VStack(alignment: .leading, spacing: 12){
                        ZStack(alignment: .bottomLeading){
                            Color.clear
                                .frame(maxWidth: .infinity)
                                .frame(height: 280)
                                .overlay{
                                    PosterImage(url: ImagePath.imageURL(imagePath: movieDetails.backdropPath, size: .large), cornerRadius: 0)
                                        
                                }
                                .clipped()
                            LinearGradient(colors: [.clear, Color.background], startPoint: .top, endPoint: .bottom)
                            VStack(alignment: .leading, spacing: 4){
                                Text(movieDetails.title)
                                    .font(.system(.title, design: . rounded, weight: .bold))
                                    .foregroundStyle(Color.textPrimary)
                                    .lineLimit(3)
                                HStack(spacing: 8){
                                    RatingBadge(voteAverage: movieDetails.voteAverage)
                                    Text(movieDetails.releaseDate?.prefix(4) ?? "")
                                    Text(movieDetails.calculateRuntime())
                                }
                                .font(.footnote)
                                .foregroundStyle(Color.textSecondary)
                            }
                            .padding(.horizontal, 16)
                        }
                        
                        // Корневой
                        VStack(alignment: .leading, spacing: 24){
                            
                            // Жанры
                            ScrollView(.horizontal, showsIndicators: false){
                                HStack(spacing: 8){
                                    ForEach(movieDetails.genres, id: \.id){ gener in
                                        GenreChip(name: gener.name, isSelected: false)
                                    }
                                }
                            }
                            
                            // Кнопки
                            HStack(spacing: 8){
                                Button(action: {
                                    //
                                }){
                                    HStack{
                                        Image(systemName: "plus")
                                        Text("Хочу посмотреть")
                                    }
                                }
                                .frame(maxWidth: .infinity, minHeight: 44)
                                .background(Color.accent, in: RoundedRectangle(cornerRadius: 12))
                                .foregroundStyle(Color.white)
                                
                                
                                Button(action: {
                                    //
                                }){
                                    Text("Просмотрено")
                                }
                                .frame(maxWidth: .infinity, minHeight: 44)
                                .background(Color.surface, in: RoundedRectangle(cornerRadius: 12))
                                .overlay{
                                    RoundedRectangle(cornerRadius: 12).strokeBorder(Color.line, lineWidth: 1)
                                    
                                }
                                .foregroundStyle(Color.textPrimary)
                            }
                            .font(.subheadline.weight(.semibold))
                            .buttonStyle(.plain)
                            
                            // Описание
                            Text(movieDetails.overview ?? "Описания нет")
                                .font(.body)
                                .foregroundStyle(Color.textSecondary)
                                .lineSpacing(4)
                        }
                        .padding(.horizontal, 16)
                        .frame(maxWidth: .infinity)
                        .frame(maxHeight: .infinity, alignment: .top)
                    }
                }
                .ignoresSafeArea(edges: .top)
            case .error(let error):
                VStack{
                    Text(String(error.errorDescription ?? "Ошибка"))
                        .foregroundStyle(Color.textSecondary)
                        .font(.subheadline)
                    Button(action: {
                        Task{
                            await viewModel.loadMovieDetails()
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
        .task{
            await viewModel.loadMovieDetails()
        }
    }
}

#Preview {
    DetailView(viewModel: DetailViewModel(movieService: MockMovieService(shouldFail: false), id: MovieDetails.detailsExample.id))
}
