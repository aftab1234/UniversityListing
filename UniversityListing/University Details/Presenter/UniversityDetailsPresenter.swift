//
//  UniversityDetailsPresenter.swift
//  UniversityListing
//
//  Created by Mohammad Aftab Sabir on 04/06/24.
//

import Foundation

protocol UniversityDetailsPresenterProtocol {
    func viewDidLoad()
}

class UniversityDetailsPresenter: UniversityDetailsPresenterProtocol {
    private let interactor: UniversityDetailsInteractorProtocol
    private weak var view: UniversityDetailsViewProtocol?
    private let university: University

    init(interactor: UniversityDetailsInteractorProtocol, view: UniversityDetailsViewProtocol, university: University) {
        self.interactor = interactor
        self.view = view
        self.university = university
    }

    func viewDidLoad() {
        view?.updateView(with: university)
    }
}

