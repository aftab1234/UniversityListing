//
//  UniversityListingViewController.swift
//  UniversityListing
//
//  Created by Mohammad Aftab Sabir on 04/06/24.
//

import UIKit

protocol UniversityListingViewProtocol: AnyObject {
    func updateView()
    func showError(error: Error)
}

class UniversityListingViewController: UIViewController, UniversityListingViewProtocol, UpdateDelegate {
    
    var presenter: UniversityListingPresenter!
    private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        presenter.fetchUniversities()
    }

    private func setupTableView() {
        tableView = UITableView(frame: view.bounds)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }

    func updateView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func showError(error: Error) {
           let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           present(alert, animated: true, completion: nil)
    }
    
    func updateUniversityListingData() {
        presenter.fetchUniversities()
    }
}

extension UniversityListingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.universities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        let university = presenter.universities[indexPath.row]
        // Set the textLabel to wrap its text instead of truncating
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.numberOfLines = 0 // 0 means unlimited number of lines
        cell.textLabel?.text = university.name
        
        cell.detailTextLabel?.text = university.state ?? ""
        // Set selection style to none
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let university = presenter.universities[indexPath.row]
        let detailsViewController = UniversityDetailsRouter.createModule(with: university)
        detailsViewController.delegate = self
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

