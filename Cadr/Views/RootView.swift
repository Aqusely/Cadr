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
    
    init(movieService: MovieService, homeViewModel: HomeViewModel) {
        self.movieService = movieService
        _homeViewModel = State(initialValue: homeViewModel)
    }
    
    var body: some View{
        NavigationStack{
            HomeView(viewModel: homeViewModel)
                .navigationDestination(for: Movie.self){ movie in
                    DetailView(viewModel: DetailViewModel(movieService: movieService, id: movie.id))
                }
        }
    }
}
