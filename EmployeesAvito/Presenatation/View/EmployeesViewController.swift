//
//  EmployeesViewController.swift
//  EmployeesAvito
//
//  Created by ayaz on 04.11.2022.
//

import UIKit

class EmployeesViewController: UIViewController, EmployeesViewProtocol {
	
	// MARK: - Private properties
	
	private var presenter: EmployeesPresenterProtocol?
	
	// MARK: - Lifecycle
	
    override func viewDidLoad() {
        super.viewDidLoad()
		guard let presenter: EmployeesPresenterProtocol = ServiceLocator.shared.resolve() else {
			return
		}
		self.presenter = presenter
    }

	// MARK: - EmployeesViewProtocol
	
	func updateData() {
		
	}
	
	func showError(message: String) {
		
	}
	
	// MARK: - Private methods
}
