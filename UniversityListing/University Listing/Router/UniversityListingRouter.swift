//
//  UniversityListingRouter.swift
//  UniversityListing
//
//  Created by Mohammad Aftab Sabir on 04/06/24.
//

import UIKit

class UniversityListingRouter {
    static func createModule() -> UniversityListingViewController {
        let view = UniversityListingViewController()
        let interactor = UniversityListingInteractor()
        let presenter = UniversityListingPresenter(interactor: interactor, view: view)
        view.presenter = presenter
        return view
    }
}

