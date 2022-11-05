//
//  NetworkingService.swift
//  EmployeesAvito
//
//  Created by ayaz on 04.11.2022.
//

import Foundation

protocol NetworkingServiceProtocol {
	
	func fetchCompanies(completionHandler: @escaping (Result<Response, Error>) -> Void)
}
