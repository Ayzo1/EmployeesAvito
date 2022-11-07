//
//  NetworkingServiceProtocol.swift
//  EmployeesAvito
//
//  Created by ayaz on 04.11.2022.
//

import Foundation

protocol RequestSenderProtocol {
	
	func send<Parser> (requestConfig: RequestConfiguration<Parser>, completionHandler: @escaping (Result<Parser.Model, Error>) -> Void)
}
