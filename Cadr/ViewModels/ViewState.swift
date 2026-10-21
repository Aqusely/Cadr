//
//  ViewState.swift
//  Cadr
//
//  Created by Наливайко Кирилл on 20.10.2026.
//

enum ViewState<T: Codable> {
    case loading
    case success(T)
    case error(APIError)
}
