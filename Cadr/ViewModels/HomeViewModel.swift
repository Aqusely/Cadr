//
//  HomeViewModel.swift
//  Cadr
//
//  Created by Наливайко Кирилл on 16.10.2026.
//

import Observation

enum MainViewState {
    case loading
    case success([Movie])
    case error(APIError)
}

@MainActor
@Observable
final class HomeViewModel{
    private let movieService: MovieService
    var state: MainViewState = .loading
    
    init(movieService: MovieService) {
        self.movieService = movieService
    }
    
    func loadPopularMovies(page: Int) async {
        state = .loading
        do{
            let result = try await movieService.popularMovies(page: page)
            state = .success(result.results)
        }catch let error as APIError{
            state = .error(error)
        }catch {
            state = .error(APIError.unexpectedError)
        }
    }
}
