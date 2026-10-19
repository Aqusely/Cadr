//
//  CadrApp.swift
//  Cadr
//
//  Created by Наливайко Кирилл on 15.10.2026.
//

import SwiftUI

@main
struct CadrApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: HomeViewModel(movieService: TMDBMovieService()))
        }
    }
}
