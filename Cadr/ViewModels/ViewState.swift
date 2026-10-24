//
//  ViewState.swift
//  Cadr
//
//  Created by Наливайко Кирилл on 20.10.2026.
//

enum ViewState<T> {
    case loading
    case success(T)
    case error(APIError)
}

enum SearchState{
    case loading
    case success([Movie])
    case error(APIError)
    case idle
    case noResults
}
