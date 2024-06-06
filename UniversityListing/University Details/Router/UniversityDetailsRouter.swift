//
//  UniversityDetailsRouter.swift
//  UniversityListing
//
//  Created by Mohammad Aftab Sabir on 04/06/24.
//

import UIKit

class UniversityDetailsRouter {
    static func createModule(with university: University) -> UniversityDetailsViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "UniversityDetailsViewController") as! UniversityDetailsViewController
        let interactor = UniversityDetailsInteractor()
        let presenter = UniversityDetailsPresenter(interactor: interactor, view: view, university: university)
        view.presenter = presenter
        return view
    }
}

