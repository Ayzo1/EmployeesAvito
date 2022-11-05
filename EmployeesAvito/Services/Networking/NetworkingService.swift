//
//  NetworkingService.swift
//  EmployeesAvito
//
//  Created by ayaz on 04.11.2022.
//

import Foundation

final class NetworkingService: NetworkingServiceProtocol {
	
	// MARK: - Private properties
	
	private var requestSender: RequestSenderProtocol?
	
	// MARK: - init
	
	init() {
		guard let sender: RequestSenderProtocol = ServiceLocator.shared.resolve() else {
			return
		}
		requestSender = sender
	}
	
	// MARK: - NetworkingServiceProtocol
	
	func fetchCompanies(completionHandler: @escaping (Result<Response, Error>) -> Void) {
		guard let requestSender = requestSender else {
			return
		}
		
		let parser = CompanyParser()
		let request = CompaniesRequest()
		let config = RequestConfiguration(request: request, parser: parser)
		
		requestSender.send(requestConfig: config) { (result) in
			switch result {
				case .success(let companies):
					completionHandler(.success(companies))
				case .failure(let error):
					completionHandler(.failure(error))
			}
		}
	}
}
