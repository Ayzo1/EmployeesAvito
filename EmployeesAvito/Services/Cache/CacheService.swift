//
//  CacheService.swift
//  EmployeesAvito
//
//  Created by ayaz on 06.11.2022.
//

import Foundation

final class CacheService: CacheServiceProtocol {
	
	// MARK: - Private properties
	
	private let cacheLifeTimeInSeconds: TimeInterval = 3600
	private let companyKey = "company"
	private let timeKey = "time"
	private var saver: SaverProtocol?
	
	// MARK: - init
	
	init() {
		guard let saver: SaverProtocol = ServiceLocator.shared.resolve() else {
			return
		}
		self.saver = saver
	}
	
	// MARK: - CacheServiceProtocol
	
	func getCompany() -> Company? {
		guard let data = saver?.getData(key: companyKey) else {
			return nil
		}
		guard let company = decodeCompany(data: data) else {
			return nil
		}
		guard let date = saver?.getDate(key: timeKey) else {
			return nil
		}
		
		if Date().timeIntervalSince(date) > cacheLifeTimeInSeconds {
			return nil
		}
		return company
	}
	
	func cacheCompany(company: Company) {
		guard let data = encodeCompany(company: company) else {
			return
		}
		saver?.saveData(key: companyKey, data: data)
		saver?.saveDate(key: timeKey, date: Date())
	}
	
	// MARK: - Private methods
	
	private func encodeCompany(company: Company) -> Data? {
		let encoder = JSONEncoder()
		do {
			let data = try encoder.encode(company)
			return data
		} catch {
			return nil
		}
	}
	
	private func decodeCompany(data: Data) -> Company? {
		let decoder = JSONDecoder()
		do {
			let company = try decoder.decode(Company.self, from: data)
			return company
		} catch {
			return nil
		}
	}
}
