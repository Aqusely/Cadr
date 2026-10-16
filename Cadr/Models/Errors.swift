//
//  Errors.swift
//  Cadr
//
//  Created by Наливайко Кирилл on 15.10.2026.
//

import Foundation

// Ошибки сервера
nonisolated enum APIError: LocalizedError {
    case noNetwork
    case missingAPIKey
    case invalidURL
    case unauthorized
    case notFound
    case serverError
    case badStatus
    case decodingFailed
    case unexpectedError
   
    
    var errorDescription: String? {
        switch self {
        case .noNetwork:
            return "Нет подключения к интернету"
        case .missingAPIKey:
            return "Приложение не настроено"
        case .invalidURL:
            return "Не удалось выполнить запрос"
        case .unauthorized:
            return "Проблема с доступом к сервису"
        case .notFound:
            return "Фильм не найден"
        case .serverError:
            return "Сервис временно недоступен"
        case .badStatus:
            return "Сервер вернул ошибку"
        case .decodingFailed:
            return "Не удалось обработать данные"
        case .unexpectedError:
            return "Неизвестная ошибка"
        }
    }
    
}


