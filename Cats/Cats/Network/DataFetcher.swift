//
//  DataFetcher.swift
//  Cats
//
//  Created by Leo van der Zee on 09/07/2023.
//

import Foundation
import Combine

protocol DataFetcherProtocol {
    func fetchData(from url: URL) -> AnyPublisher<Data, Error>
}

struct DataFetcherDefault: DataFetcherProtocol {
    
    func fetchData(from url: URL) -> AnyPublisher<Data, Error>{
        URLSession.shared.dataTaskPublisher(for: url)
            .map { ($0.data) }
            .mapError { $0 }
            .eraseToAnyPublisher()
    }
}
