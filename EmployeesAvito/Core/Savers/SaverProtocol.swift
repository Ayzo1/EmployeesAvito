//
//  UserDefaultsSaverProtocol.swift
//  EmployeesAvito
//
//  Created by ayaz on 06.11.2022.
//

import Foundation

protocol SaverProtocol {
	
	func saveData(key: String, data: Data)
	func saveDate(key: String, date: Date)
	func getData(key: String) -> Data?
	func getDate(key: String) -> Date?
}
