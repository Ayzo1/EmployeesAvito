//
//  EmployeesPresenterProtocol.swift
//  EmployeesAvito
//
//  Created by ayaz on 04.11.2022.
//

import Foundation

protocol EmployeesPresenterProtocol {
	
	func getCompaniesCount() -> Int
	func getEmployeesCount(for conmpanyIndex: Int) -> Int
	func getEmployee(for conmpanyIndex: Int, employeeIndex: Int) -> Employee?
	func getCompanyName() -> String?
	func updateCompany()
}
