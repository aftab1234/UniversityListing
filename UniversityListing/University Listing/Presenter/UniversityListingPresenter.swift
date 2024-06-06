//
//  UniversityListingPresenter.swift
//  UniversityListing
//
//  Created by Mohammad Aftab Sabir on 04/06/24.
//

import Foundation

protocol UniversityListingPresenterProtocol {
    var universities: [University] { get }
    func fetchUniversities()
}

class UniversityListingPresenter: UniversityListingPresenterProtocol {
    private let interactor: UniversityListingInteractor
    private weak var view: UniversityListingViewProtocol?
    var universities: [University] = []

    init(interactor: UniversityListingInteractor, view: UniversityListingViewProtocol) {
        self.interactor = interactor
        self.view = view
    }

    func fetchUniversities() {
        interactor.fetchUniversities { [weak self] result in
            switch result {
            case .success(let universities):
                self?.universities = universities
                self?.view?.updateView()
            case .failure(let error):
                self?.view?.showError(error: error)
            }
        }
    }
}

