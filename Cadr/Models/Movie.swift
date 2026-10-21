//
//  Movie.swift
//  Cadr
//
//  Created by Наливайко Кирилл on 15.10.2026.
//

import Foundation

nonisolated struct Genre: Codable, Identifiable, Hashable{
    let id: Int
    let name: String
}


// Для Деталей
nonisolated struct MovieDetails: Codable, Identifiable, Hashable{
    let id: Int
    let title: String
    let voteAverage: Double
    let genres: [Genre]
    
    // Optional
    let releaseDate: String?
    let overview: String?
    let backdropPath: String?
    let posterPath: String?
    let runtime: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case releaseDate = "release_date"
        case overview = "overview"
        case voteAverage = "vote_average"
        case genres = "genres"
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case runtime = "runtime"
    }
    
    func calculateRuntime() -> String {
        guard let duration = runtime, duration != 0 else { return ""}
        
        let hours = duration / 60
        let minutes = duration % 60
        
        switch duration{
        case 1..<60:
            return "\(minutes) мин"
        case 60:
            return "1 ч"
        case 61...:
            return "\(hours) ч \(minutes) мин"
        default:
            return "\(hours) ч \(minutes) мин"
        }
    }
}

// Для списков
nonisolated struct Movie: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let voteAverage: Double
    
    // Optional
    let releaseDate: String?
    let backdropPath: String?
    let posterPath: String?

    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        
    }
}

// Структура для приема ответа от сервера
nonisolated struct TakeAnswerFromServer<Item: Codable>: Codable {
    let page: Int
    let results: [Item]
}
