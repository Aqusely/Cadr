//
//  ExtentionMovie.swift
//  Cadr
//
//  Created by Наливайко Кирилл on 19.10.2026.
//

extension Movie{
    static let movieExample: [Movie] = [
        Movie(
            id: 1,
            title: "В поисках немо, и еще что то для длинного названия",
            voteAverage: 8.4,
            releaseDate: "2022-04-12",
            backdropPath: nil,
            posterPath: nil),
        Movie(
            id: 2,
            title: "Стражи галактики",
            voteAverage: 7.4,
            releaseDate: "2020-06-26",
            backdropPath: "/nDxJJyA5giRhXx96q1sWbOUjMBI.jpg",
            posterPath: "/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg"),
        Movie(
            id: 3,
            title: "Смешарики",
            voteAverage: 9.2,
            releaseDate: "2025-01-01",
            backdropPath: "/nDxJJyA5giRhXx96q1sWbOUjMBI.jpg",
            posterPath: nil),
        Movie(
            id: 6,
            title: "Сумерки",
            voteAverage: 0,
            releaseDate: "2025-01-01",
            backdropPath: "/nDxJJyA5giRhXx96q1sWbOUjMBI.jpg",
            posterPath: nil)
    ]
}

extension MovieDetails{
    static let detailsExample: MovieDetails  = MovieDetails(
            id: 137696,
            title: "В поисках немо",
            voteAverage: 8.4,
            genres: [
                Genre(
                    id: 16,
                    name: "Мультфильм"),
                Genre(
                    id: 10751,
                    name: "Семейный"),
                Genre(
                    id: 12,
                    name: "Приключения")
            ],
            releaseDate: "2003-05-30",
            overview: "Nemo, an adventurous young clownfish, is unexpectedly taken from his Great Barrier Reef home to a dentist's office aquarium. It's up to his worrisome father Marlin and a friendly but forgetful fish Dory to bring Nemo home -- meeting vegetarian sharks, surfer dude turtles, hypnotic jellyfish, hungry seagulls, and more along the way.",
            backdropPath: "/yzqaKAhglTrkeOfuIXYYArf0WnA.jpg",
            posterPath: "/cCovtlN16ykvyFYnzKyv3dFtceG.jpg",
            runtime: 100)
}
