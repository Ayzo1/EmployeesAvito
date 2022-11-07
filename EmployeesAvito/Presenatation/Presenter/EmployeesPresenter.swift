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
	
	private var company: Company?
	private var networkingService: NetworkingServiceProtocol?
	private var cacheService: CacheServiceProtocol?
	
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
		guard let cacheService: CacheServiceProtocol = ServiceLocator.shared.resolve() else {
			return
		}
		self.cacheService = cacheService
		getCompany()
	}
	
	// MARK: - EmployeesPresenterProtocol
	
	func getCompaniesCount() -> Int {
		return company != nil ? 1 : 0
	}
	
	func getEmployeesCount(for conmpanyIndex: Int) -> Int {
		return company?.employees.count ?? 0
	}
	
	func getEmployee(for conmpanyIndex: Int, employeeIndex: Int) -> Employee? {
		return company?.employees[employeeIndex]
	}
	
	func getCompanyName() -> String? {
		company?.name
	}
	
	func updateCompany() {
		downloadCompany()
	}
	
	// MARK: - Private methods
	
	private func getCompany() {
		company = cacheService?.getCompany()
		view?.updateData()
		downloadCompany()
	}
	
	private func downloadCompany() {
		guard let networkingService = networkingService else {
			return
		}
		
		networkingService.fetchCompanies { [weak self] (result) in
			switch result {
				case .success(let response):
					var downloadedCompany = response.company
					downloadedCompany.employees.sort(by: { (e1, e2) -> Bool in
						e1.name < e2.name
					})
					self?.company = downloadedCompany
					self?.cacheService?.cacheCompany(company: downloadedCompany)
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
				view?.updateData()
				view?.showError(message: "Нет интернета")
			case .parseError:
				break
			case .urlError:
				break
		}
	}
}
