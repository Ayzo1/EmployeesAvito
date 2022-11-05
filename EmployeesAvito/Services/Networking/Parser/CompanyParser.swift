//
//  CompanyParser.swift
//  EmployeesAvito
//
//  Created by ayaz on 04.11.2022.
//

import Foundation

final class CompanyParser: ParserProtocol {
	
	typealias Model = Response
	
	func parse(data: Data) -> Model? {
		do {
			let decoder = JSONDecoder()
			let parsedData = try decoder.decode(Model.self, from: data)
			return parsedData
		} catch {
			return nil
		}
	}
}
