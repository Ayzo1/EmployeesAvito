//
//  RequestConfiguration.swift
//  EmployeesAvito
//
//  Created by ayaz on 04.11.2022.
//

import Foundation

struct RequestConfiguration<Parser> where Parser: ParserProtocol {
	let request: RequestProtocol
	let parser: Parser
}
