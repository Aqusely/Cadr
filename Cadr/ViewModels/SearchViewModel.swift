//
//  SearchViewModel.swift
//  Cadr
//
//  Created by Наливайко Кирилл on 22.10.2026.
//
import Foundation
import Observation

@MainActor
@Observable
final class SearchViewModel{
    private let movieService: MovieService
    var state: SearchState = .idle
    var textRequest: String = ""
    
    init(movieService: MovieService) {
        self.movieService = movieService
    }
    
    func searchMovie() async {
        let text = textRequest.trimmingCharacters(in: .whitespacesAndNewlines) //Убираем пробелы
        guard !text.isEmpty else {
            state = .idle
            return
        }
        state = .loading //Ставим состояние в .loading
        do{
            let result = try await movieService.searchMovies(for: text) //Делаем запрос на сервер
            // Проверяем не отменена ли задача
            guard !Task.isCancelled else { return }
            // Проверяем что ответ не пустой
            if result.results.isEmpty{
                state = .noResults
            }else{
                state = .success(result.results)
            }
        }catch let error as APIError{
            state = .error(error)
        }catch is CancellationError{
            return
        }catch {
            state = .error(APIError.unexpectedError)
        }
    }
}
