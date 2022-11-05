//
//  ParserProtocol.swift
//  EmployeesAvito
//
//  Created by ayaz on 04.11.2022.
//

import Foundation

protocol ParserProtocol {
	
	associatedtype Model
	
	func parse(data: Data) -> Model?
}
