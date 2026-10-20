//
//  MockMovieService.swift
//  Cadr
//
//  Created by Наливайко Кирилл on 19.10.2026.
//

struct MockMovieService: MovieService{
    
    let shouldFail: Bool
    
    func popularMovies(page number: Int) async throws -> TakeAnswerFromServer<Movie> {
        if !shouldFail{
            try await Task.sleep(for: .seconds(3))
            return TakeAnswerFromServer(page: 1, results: Movie.movieExample)
        }else{
            try await Task.sleep(for: .seconds(3))
            throw APIError.unexpectedError
        }
    }
    
    func searchMovies(for query: String) async throws -> TakeAnswerFromServer<Movie> {
        if !shouldFail{
            return TakeAnswerFromServer(page: 1, results: Movie.movieExample)
        }else {
            throw APIError.unexpectedError
        }
    }
    
    func movieDetails(for id: Int) async throws -> MovieDetails {
        if !shouldFail {
            try await Task.sleep(for: .seconds(3))
            return MovieDetails.detailsExample
        }else{
            try await Task.sleep(for: .seconds(3))
            throw APIError.unexpectedError
        }
    }
}
