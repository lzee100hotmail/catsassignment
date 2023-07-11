//
//  CatsOverviewFetcher.swift
//  Cats
//
//  Created by Leo van der Zee on 09/07/2023.
//

import Foundation
import Combine

protocol CatsOverviewFetcherProtocol {
    func fetch() -> AnyPublisher<Cats, Error>
}

struct CatsOverviewFetcher: CatsOverviewFetcherProtocol {
    
    enum CatsOverviewFetcherError: Error {
        case invalidURL
    }
    
    private let url = URL(string: "https://api.thecatapi.com/v1/breeds/?page=1&limit=12")
    private let dataFetcher: DataFetcherProtocol
    private let decoder = JSONDecoder()

    init(dataFetcher: DataFetcherProtocol = DataFetcherDefault()) {
        self.dataFetcher = dataFetcher
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func fetch() -> AnyPublisher<Cats, Error> {
        guard let url else {
            return Fail(error: CatsOverviewFetcherError.invalidURL)
                .eraseToAnyPublisher()
        }
        return dataFetcher.fetchData(from: url)
            .decode(type: Cats.self, decoder: decoder)
            .mapError { $0 }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    
}
