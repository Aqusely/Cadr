//
//  TMDBMovieService.swift
//  Cadr
//
//  Created by Наливайко Кирилл on 15.10.2026.
//

import Foundation

struct TMDBMovieService: MovieService {

    // MARK: Популярные фильмы
    func popularMovies(page number: Int) async throws -> TakeAnswerFromServer<Movie> {
        
        // Создаем URL
        var components = try baseComponents()
        components.path = "/3/movie/popular"
        components.queryItems?.append(URLQueryItem(name: "page", value: String(number)))
        
        guard let url = components.url else { throw APIError.invalidURL }
        
        return try await tryLoad(url: url)
    }
    
    // MARK: Поиск по фильмам
    func searchMovies(for query: String) async throws -> TakeAnswerFromServer<Movie>{
        // Создаем URL
        var components = try baseComponents()
        components.path = "/3/search/movie"
        components.queryItems?.append(URLQueryItem(name: "query", value: query))
        
        guard let url = components.url else { throw APIError.invalidURL }
        
        return try await tryLoad(url: url)
    }
    
    // MARK: Детали фильма
    func movieDetails(for id: Int) async throws -> MovieDetails {
        
        // Создаем URL
        var components = try baseComponents()
        components.path = "/3/movie/\(id)"
        
        guard let url = components.url else { throw APIError.invalidURL }
        
        return try await tryLoad(url: url)
    }
    
    // Обработка статус кода
    private func checkData(data: Data, response: URLResponse) throws -> Data {
        
        guard let http = response as? HTTPURLResponse else {
            throw APIError.unexpectedError
        }
        
        switch http.statusCode{
        case 200..<300:
            return data
        case 401:
            throw APIError.unauthorized
        case 404:
            throw APIError.notFound
        case (400..<500):
            throw APIError.badStatus
        case 500...:
            throw APIError.serverError
        default:
            throw APIError.unexpectedError
        }
         
    }
    
    // Создать URl
    private func baseComponents() throws  -> URLComponents{
        
        // Достаем API_Key из info.plist
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "TMDB_API_KEY") as? String else { throw APIError.missingAPIKey}
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "language", value: "ru-RU")
        ]
        
        return components
    }
    
    // Обобщенный do-catch
    private func tryLoad<T: Decodable>(url: URL) async throws -> T{
        do{
            let (data, response) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(T.self, from: checkData(data: data, response: response))
            
        }catch let error as URLError {
            if error.code.rawValue == -1009 {
                throw APIError.noNetwork
            }else{
                throw APIError.unexpectedError
            }
        }catch let error as APIError{
            throw error
        }catch is DecodingError{
            throw APIError.decodingFailed
        }catch {
            throw APIError.unexpectedError
        }
    }
}

