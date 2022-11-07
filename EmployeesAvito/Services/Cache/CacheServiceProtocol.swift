//
//  CacheServiceProtocol.swift
//  EmployeesAvito
//
//  Created by ayaz on 06.11.2022.
//

import Foundation

protocol CacheServiceProtocol {
	
	func getCompany() -> Company?
	func cacheCompany(company: Company)
}
