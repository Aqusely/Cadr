//
//  CadrApp.swift
//  Cadr
//
//  Created by Наливайко Кирилл on 15.10.2026.
//

import SwiftUI

@main
struct CadrApp: App {
    
    let service = TMDBMovieService()
    
    var body: some Scene {
        WindowGroup {
            RootView(movieService: service, homeViewModel: HomeViewModel(movieService: service), searchViewModel: SearchViewModel(movieService: service))
        }
    }
}
