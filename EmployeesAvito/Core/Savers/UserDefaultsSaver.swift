//
//  UserDefaultsSaver.swift
//  EmployeesAvito
//
//  Created by ayaz on 06.11.2022.
//

import Foundation

final class UserDefaultsSaver: SaverProtocol {
	
	// MARK: - Private properties
	
	private let defaults = UserDefaults.standard
	
	// MARK: - init
	
	init() {
		
	}

	// MARK: - SaverProtocol
	
	func saveData(key: String, data: Data) {
		defaults.setValue(data, forKey: key)
	}
	
	func saveDate(key: String, date: Date) {
		defaults.setValue(date, forKey: key)
	}

	func getData(key: String) -> Data? {
		return defaults.data(forKey: key)
	}

	func getDate(key: String) -> Date? {
		return defaults.object(forKey: key) as? Date
	}
}
