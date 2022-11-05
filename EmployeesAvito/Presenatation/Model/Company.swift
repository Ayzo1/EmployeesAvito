//
//  Company.swift
//  EmployeesAvito
//
//  Created by ayaz on 04.11.2022.
//

import Foundation

struct Response: Codable {
	let company: Company
}

struct Company: Codable {
	let name: String
	let employees: [Employee]
}
