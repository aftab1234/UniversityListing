//
//  UniversityListingInteractor.swift
//  UniversityListing
//
//  Created by Mohammad Aftab Sabir on 04/06/24.
//

import RealmSwift

protocol UniversityListingInteractorProtocol {
    func fetchUniversities(completion: @escaping (Result<[University], Error>) -> Void)
}

class UniversityListingInteractor: UniversityListingInteractorProtocol {
    let realm = try! Realm()

    func fetchUniversities(completion: @escaping (Result<[University], Error>) -> Void) {
        NetworkManager.shared.fetchUniversities { result in
            switch result {
            case .success(let universities):
                try! self.realm.write {
                    self.realm.add(universities, update: .modified)
                }
                completion(.success(universities))
            case .failure(let error):
                let cachedUniversities = self.realm.objects(University.self)
                if !cachedUniversities.isEmpty {
                    completion(.success(Array(cachedUniversities)))
                } else {
                    completion(.failure(error))
                }
            }
        }
    }
}

