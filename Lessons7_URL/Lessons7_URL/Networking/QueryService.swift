//
//  QueryService.swift
//  Lessons7_URL
//
//  Created by Боровик Василий on 30.11.2020.
//

import Foundation
import UIKit

final class QueryService {
	private let defaultSession = URLSession(configuration: .default)
	private var dataTask: URLSessionDataTask?
	private var errorMessage = ""
	private var responseData = Data()
	
	typealias QueryResult = (Data, String) -> Void
	
	func getSearchResults(url: String, completion: @escaping QueryResult) {
		self.dataTask?.cancel()
		
		guard let url = URL(string: url) else { return assertionFailure("Not url") }
		self.dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
			defer {
				self?.dataTask = nil
			}
			
			if let error = error {
				self?.errorMessage += "Data task error: " + error.localizedDescription + "\n"
			} else if let data = data,
					  let response = response as? HTTPURLResponse,
					  response.statusCode == 200 {
				print(data)
				self?.responseData = data
				print(self?.responseData)
			}
			
			
			
			DispatchQueue.main.async {
				completion(self?.responseData ?? Data(), self?.errorMessage ?? "")
			}
		}
		self.dataTask?.resume()
	}
}
