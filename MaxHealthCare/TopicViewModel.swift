//
//  TopicViewModel.swift
//  MaxHealthCare
//
//  Created by VJ on 22/02/24.
//

import Foundation
import KRProgressHUD
class TopicViewModel {
    
    // MARK: VARABLES
    var resources: [Resource] = []
    var section : [Section] = []
    
    var resourceCount: Int {
        return resources.count
    }
    
    enum FetchResult {
        case success
        case failure(Error)
    }
    
    // function to hit the api where we check the completion of api it is success or not 
    func fetchData(withId id: Int? = nil, completion: @escaping (FetchResult) -> Void) {
        KRProgressHUD.show()
        let urlString: String
        if let id = id {
            urlString = "https://health.gov/myhealthfinder/api/v3/topicsearch.json?TopicId=\(id)"
        } else {
            urlString = "https://health.gov/myhealthfinder/api/v3/topicsearch.json"
        }
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            KRProgressHUD.dismiss()
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                KRProgressHUD.dismiss()
                completion(.failure(error ?? NetworkError.unknownError))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(RootResponse.self, from: data)
                self?.resources = response.result.resources.resource 
                if let sectiondata = response.result.resources.resource.first?.sections.section{
                    self?.section = sectiondata
                }
                KRProgressHUD.dismiss()
                completion(.success)
            } catch {
                print("Error decoding data: \(error)")
                KRProgressHUD.dismiss()
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
 
}

enum NetworkError: Error {
    case invalidURL
    case unknownError
}


