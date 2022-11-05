//
//  EmployeesPresenter.swift
//  EmployeesAvito
//
//  Created by ayaz on 04.11.2022.
//

import Foundation

final class EmployeesPresenter: EmployeesPresenterProtocol {
	
	// MARK: - Properties
	
	weak var view: EmployeesViewProtocol?
	
	// MARK: - Private properties
	
	private var companies: [Company] = [Company]()
	private var networkingService: NetworkingServiceProtocol?
	
	// MARK: - init
	
	init() {
		guard let view: EmployeesViewProtocol = ServiceLocator.shared.resolve() else {
			return
		}
		self.view = view
		guard let networkingService: NetworkingServiceProtocol = ServiceLocator.shared.resolve() else {
			return
		}
		self.networkingService = networkingService
		getCompanies()
	}
	
	// MARK: - EmployeesPresenterProtocol
	
	func getCompaniesCount() -> Int {
		return companies.count
	}
	
	func getEmployeesCount(for conmpanyIndex: Int) -> Int {
		return companies[conmpanyIndex].employees.count
	}
	
	func getEmployee(for conmpanyIndex: Int, employeeIndex: Int) -> Employee {
		return companies[conmpanyIndex].employees[employeeIndex]
	}
	
	// MARK: - Private methods
	
	private func getCompanies() {
		guard let networkingService = networkingService else {
			return
		}
		
		networkingService.fetchCompanies { [weak self] (result) in
			switch result {
				case .success(let company):
					self?.companies.append(company.company)
					self?.view?.updateData()
			case .failure(let error):
				self?.prepareError(error: error)
			}
		}
	}
	
	private func prepareError(error: Error) {
		guard let error = error as? NetworkingError else {
			return
		}
		
		switch error {
			case .fetchError:
				break
			case .parseError:
				break
			case .urlError:
				break
		}
	}
}
