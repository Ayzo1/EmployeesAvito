//
//  Employee.swift
//  EmployeesAvito
//
//  Created by ayaz on 04.11.2022.
//

import Foundation

struct Employee: Codable {
	
	let name: String
	let phoneNumber: String
	let skills: [String]
	
	enum CodingKeys: String, CodingKey {
		case name
		case phoneNumber = "phone_number"
		case skills
	}
}
