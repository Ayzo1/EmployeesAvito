//
//  EmployeeCollectionViewCell.swift
//  EmployeesAvito
//
//  Created by ayaz on 05.11.2022.
//

import UIKit

class EmployeeCollectionViewCell: UICollectionViewCell {
	
	private lazy var roundedView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
    
	func configurate(name: String, number: String, skills: [String]) {
		
	}
}
