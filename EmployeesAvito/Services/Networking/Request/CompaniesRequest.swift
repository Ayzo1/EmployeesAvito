//
//  CompaniesRequest.swift
//  EmployeesAvito
//
//  Created by ayaz on 04.11.2022.
//

import Foundation

final class CompaniesRequest: RequestProtocol {
	
	var request: URLRequest?
	
	init() {
		guard let url = URL(string: "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c") else {
			return
		}
		self.request = .init(url: url)
	}
}
