//
//  NetworkingService.swift
//  EmployeesAvito
//
//  Created by ayaz on 04.11.2022.
//

import Foundation

final class RequestSender: RequestSenderProtocol {
	
	// MARK: - Private properties
	
	private let configuration: URLSessionConfiguration = .default
	private lazy var session = URLSession(configuration: configuration)
	
	// MARK: - RequestSenderProtocol
	
	func send<Parser>(requestConfig: RequestConfiguration<Parser>, completionHandler: @escaping (Result<Parser.Model, Error>) -> Void) where Parser : ParserProtocol {
		
		guard let request = requestConfig.request.request else {
			completionHandler(.failure(NetworkingError.urlError))
			return
		}
		
		let dataTask = session.dataTask(with: request) { (data, response, error) in
			guard (response as? HTTPURLResponse)?.statusCode == 200,
				  let data = data,
				  error == nil
			else {
				completionHandler(.failure(NetworkingError.fetchError))
				return
			}
			guard let parsedData = requestConfig.parser.parse(data: data) else {
				completionHandler(.failure(NetworkingError.parseError))
				return
			}
			completionHandler(.success(parsedData))
		}
		
		dataTask.resume()
	}
}
