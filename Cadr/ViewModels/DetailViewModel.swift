//
//  DetailViewModel.swift
//  Cadr
//
//  Created by Наливайко Кирилл on 20.10.2026.
//

import Observation

@MainActor
@Observable
final class DetailViewModel {
    private let movieService: MovieService
    var state: ViewState<MovieDetails> = .loading
    
    init(movieService: MovieService, id: Int) {
        self.movieService = movieService
    }
    
    func loadMovieDetails(for id: Int) async {
        state = .loading
        do{
            let result = try await movieService.movieDetails(for: id)
            state = .success(result)
        }catch let error as APIError{
            state = .error(error)
        }catch{
            state = .error(APIError.unexpectedError)
        }
    }
}
