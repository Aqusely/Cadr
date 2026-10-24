//
//  RootView.swift
//  Cadr
//
//  Created by Наливайко Кирилл on 21.10.2026.
//

import SwiftUI

struct RootView: View{
    
    private let movieService: MovieService
    @State private var homeViewModel: HomeViewModel
    @State private var searchViewModel: SearchViewModel
    
    init(movieService: MovieService, homeViewModel: HomeViewModel, searchViewModel: SearchViewModel) {
        self.movieService = movieService
        _homeViewModel = State(initialValue: homeViewModel)
        _searchViewModel = State(initialValue: searchViewModel)
    }
    
    var body: some View{
            TabView{
                NavigationStack{
                    HomeView(viewModel: homeViewModel)
                        .navigationDestination(for: Movie.self){ movie in
                            DetailView(viewModel: DetailViewModel(movieService: movieService, id: movie.id))
                        }
                }
                .tabItem{
                    Label("Главная", systemImage: "house")
                }
                
                NavigationStack{
                    SearchView(viewModel: searchViewModel)
                        .navigationDestination(for: Movie.self){ movie in
                            DetailView(viewModel: DetailViewModel(movieService: movieService, id: movie.id))
                        }
                }
                .tabItem{
                    Label("Поиск", systemImage: "magnifyingglass")
                }
            }
            .tint(Color.accent)
            .toolbarBackground(Color.surface, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarColorScheme(.dark, for: .tabBar)
        
    }
}
