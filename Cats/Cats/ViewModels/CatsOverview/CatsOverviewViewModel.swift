//
//  CatsOverviewViewModel.swift
//  Cats
//
//  Created by Leo van der Zee on 09/07/2023.
//

import Foundation
import Combine

class CatsOverviewViewModel {
    
    enum State {
        case loading
        case loaded
        case error
    }
    
    let title = "Cats"
    let errorMessage = "We could not get the data"
    let errorAction = "Ok"
    private(set) var state: State = .loading
    private(set) var cats: [Cat] = []
    private let catsOverviewFetcher: CatsOverviewFetcherProtocol
    private var cancables: [AnyCancellable] = []
    private var stateSubject = PassthroughSubject<State, Never>()

    init(catsOverviewFetcher: CatsOverviewFetcherProtocol = CatsOverviewFetcher()) {
        self.catsOverviewFetcher = catsOverviewFetcher
    }
    
    func bind() -> AnyPublisher<State, Never> {
        stateSubject.eraseToAnyPublisher()
    }
    
    func loadData() {
        self.stateSubject.send(state)
        self.catsOverviewFetcher.fetch().sink { [weak self] completion in
            guard let self else { return }
            switch completion {
            case .failure(let error):
                print(error)
                self.state = .error
            case .finished: self.state = .loaded
            }
            self.stateSubject.send(self.state)
        } receiveValue: { [weak self] cats in
            guard let self else { return }
            self.cats = cats
            self.state = .loaded
            self.stateSubject.send(self.state)
        }.store(in: &cancables)
    }
    
}
