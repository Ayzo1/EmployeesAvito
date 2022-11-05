//
//  EmployeesViewProtocol.swift
//  EmployeesAvito
//
//  Created by ayaz on 04.11.2022.
//

import Foundation

protocol EmployeesViewProtocol: AnyObject {
	
	func updateData()
	func showError(message: String)
}
