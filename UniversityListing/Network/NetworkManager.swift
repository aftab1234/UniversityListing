//
//  NetworkManager.swift
//  UniversityListing
//
//  Created by Mohammad Aftab Sabir on 04/06/24.
//

import Alamofire

class NetworkManager {
    static let shared = NetworkManager()

    func fetchUniversities(completion: @escaping (Result<[University], Error>) -> Void) {
        AF.request(URLPath.universityListURL).responseDecodable(of: [University].self) { response in
            switch response.result {
            case .success(let universities):
                completion(.success(universities))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

