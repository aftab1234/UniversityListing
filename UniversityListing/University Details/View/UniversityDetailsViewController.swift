//
//  UniversityDetailsViewController.swift
//  UniversityListing
//
//  Created by Mohammad Aftab Sabir on 04/06/24.
//

import UIKit

protocol UniversityDetailsViewProtocol: AnyObject {
    func updateView(with university: University)
}

protocol UpdateDelegate {
    func updateUniversityListingData()
}

class UniversityDetailsViewController: UIViewController, UniversityDetailsViewProtocol {
    var presenter: UniversityDetailsPresenterProtocol!

    @IBOutlet weak var universityNameLbl: UILabel!
    @IBOutlet weak var universityStateLbl: UILabel!
    @IBOutlet weak var universityCountryLbl: UILabel!
    @IBOutlet weak var universityCountryCodeLbl: UILabel!
    @IBOutlet weak var universityWebLinkTextView: UITextView!
    @IBOutlet weak var refreshBtn: UIButton!
    
    var delegate: UpdateDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        presenter.viewDidLoad()
    }

    func updateView(with university: University) {
        // Update the view with university details
        self.title = Constants.universityDetailtitle
        universityNameLbl.text = university.name
        universityStateLbl.text = university.state
        universityCountryLbl.text = university.country
        universityCountryCodeLbl.text = university.countryCode
        
        universityWebLinkTextView.isUserInteractionEnabled = true
        universityWebLinkTextView.isSelectable = true
        universityWebLinkTextView.dataDetectorTypes = .link
        let webPagesText = university.webPages.map { $0.value }.joined(separator: "\n")
        universityWebLinkTextView.text = webPagesText
        universityWebLinkTextView.isEditable = false
    }
    
    @IBAction func refreshBtnClicked(_ sender: Any) {
        delegate?.updateUniversityListingData()
        navigationController?.popViewController(animated: true)
    }
    
}

