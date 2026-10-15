//
//  Movie.swift
//  Cadr
//
//  Created by Наливайко Кирилл on 15.10.2026.
//

import Foundation

struct Genre: Codable, Identifiable{
    let id: Int
    let name: String
}


// Для Деталей
struct MovieDetails: Codable, Identifiable{
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
}

// Для списков
struct Movie: Codable, Identifiable {
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
struct TakeAnswerFromServer<Item: Codable>: Codable {
    let page: Int
    let results: [Item]
}
