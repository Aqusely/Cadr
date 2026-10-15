//
//  CadrTests.swift
//  CadrTests
//
//  Created by Наливайко Кирилл on 16.10.2026.
//

import Testing
@testable import Cadr
import Foundation

struct CadrTests {
    
    @Test(arguments: [
        ("/cCovtlN16ykvyFYnzKyv3dFtceG.jpg", ImagePath.Width.large, "https://image.tmdb.org/t/p/w780/cCovtlN16ykvyFYnzKyv3dFtceG.jpg"),
        ("/cCovtlN16ykvyFYnzKyv3dFtceG.jpg", ImagePath.Width.medium, "https://image.tmdb.org/t/p/w500/cCovtlN16ykvyFYnzKyv3dFtceG.jpg"),
        ("/cCovtlN16ykvyFYnzKyv3dFtceG.jpg", ImagePath.Width.small, "https://image.tmdb.org/t/p/w342/cCovtlN16ykvyFYnzKyv3dFtceG.jpg"),
        (nil, ImagePath.Width.large, nil),
    ])
    func imageURL(path: String?, size: ImagePath.Width, result: String?) {
        let url: URL? = ImagePath.imageURL(imagePath: path, size: size)
        
        #expect(url == result.flatMap{URL(string: $0)})
    }
}

