//
//  ImagePath.swift
//  Cadr
//
//  Created by Наливайко Кирилл on 15.10.2026.
//

import Foundation

struct ImagePath{
    
    enum Width: String {
        case small = "w342"
        case medium = "w500"
        case large = "w780"
    }

    static func imageURL(imagePath: String?, size: Width) -> URL?{
        
        guard let imagePath = imagePath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/\(size.rawValue)\(imagePath)")
    }
}
