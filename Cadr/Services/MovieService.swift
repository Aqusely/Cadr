//
//  MovieService.swift
//  Cadr
//
//  Created by Наливайко Кирилл on 15.10.2026.
//

protocol MovieService {
    func popularMovies(page number: Int) async throws -> TakeAnswerFromServer<Movie>
    func searchMovies(for query: String) async throws -> TakeAnswerFromServer<Movie>
    func movieDetails(for id: Int) async throws -> MovieDetails
}
