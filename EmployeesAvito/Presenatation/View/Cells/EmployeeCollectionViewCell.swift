//
//  EmployeeCollectionViewCell.swift
//  EmployeesAvito
//
//  Created by ayaz on 05.11.2022.
//

import UIKit

class EmployeeCollectionViewCell: UICollectionViewCell {
	
	static let identifirer = String(describing: EmployeeCollectionViewCell.self)
	
	// MARK: - Private properties
	
	private lazy var roundedView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = Colors.secondBackgroundColor
		view.layer.cornerRadius = 20
		return view
	}()
	
	private lazy var nameLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 20, weight: .bold)
		label.textColor = Colors.textColor
		return label
	}()
	
	private lazy var numberLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 16, weight: .regular)
		label.textColor = Colors.secondTextColor
		return label
	}()
	
	private lazy var skillsView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		// view.backgroundColor = .white
		view.layer.cornerRadius = 20
		return view
	}()
	
	private lazy var skillsTitleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 20, weight: .bold)
		label.textColor = Colors.textColor
		label.textAlignment = .center
		return label
	}()
	
	private lazy var skillsLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 16, weight: .medium)
		label.textColor = Colors.secondTextColor
		label.numberOfLines = 0
		label.lineBreakMode = .byWordWrapping
		label.textAlignment = .center
		return label
	}()
    
	// MARK: - Public methods
	
	func configurate(name: String, number: String, skills: [String]) {
		
		nameLabel.text = name
		numberLabel.text = number
		skillsTitleLabel.text = "Skills"
		skillsLabel.text = skills.joined(separator: ", ")
		
		setupRoundedView()
		setupNameLabel()
		setupNumberLabel()
		setupSkillsView()
		setupSkillsTitleLabel()
		setupSkillsLabel()
	}
	
	// MARK: - Private methods
	
	private func setupRoundedView() {
		contentView.addSubview(roundedView)
		roundedView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
		roundedView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
		roundedView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
		roundedView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
		roundedView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
		roundedView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
		addShadowToRoundedView()
	}
	
	private func addShadowToRoundedView() {
		let roundedRectPath = CGPath(roundedRect: roundedView.bounds, cornerWidth: 20, cornerHeight: 20, transform: nil)
		roundedView.layer.shadowPath = roundedRectPath
		roundedView.layer.shadowColor = UIColor.black.cgColor
		roundedView.layer.shadowOpacity = 0.5
		roundedView.layer.shadowOffset = CGSize(width: 0, height: 10)
		roundedView.layer.shadowRadius = 5
	}
	
	private func setupNameLabel() {
		roundedView.addSubview(nameLabel)
		nameLabel.topAnchor.constraint(equalTo: roundedView.topAnchor, constant: 10).isActive = true
		nameLabel.leadingAnchor.constraint(equalTo: roundedView.leadingAnchor, constant: 25).isActive = true
		nameLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
	}
	
	private func setupNumberLabel() {
		roundedView.addSubview(numberLabel)
		numberLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
		numberLabel.leadingAnchor.constraint(equalTo: roundedView.leadingAnchor, constant: 25).isActive = true
		numberLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
	}
	
	private func setupSkillsView() {
		roundedView.addSubview(skillsView)
		skillsView.topAnchor.constraint(equalTo: roundedView.topAnchor, constant: 0).isActive = true
		skillsView.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 0).isActive = true
		skillsView.trailingAnchor.constraint(equalTo: roundedView.trailingAnchor, constant: 0).isActive = true
		skillsView.bottomAnchor.constraint(equalTo: roundedView.bottomAnchor, constant: 0).isActive = true
	}
	
	private func setupSkillsTitleLabel() {
		skillsView.addSubview(skillsTitleLabel)
		skillsTitleLabel.topAnchor.constraint(equalTo: skillsView.topAnchor, constant: 10).isActive = true
		skillsTitleLabel.leadingAnchor.constraint(equalTo: skillsView.leadingAnchor, constant: 0).isActive = true
		skillsTitleLabel.trailingAnchor.constraint(equalTo: skillsView.trailingAnchor, constant: 0).isActive = true
	}
	
	private func setupSkillsLabel() {
		skillsView.addSubview(skillsLabel)
		skillsLabel.leadingAnchor.constraint(equalTo: skillsView.leadingAnchor, constant: 0).isActive = true
		skillsLabel.trailingAnchor.constraint(equalTo: skillsView.trailingAnchor, constant: 0).isActive = true
		skillsLabel.topAnchor.constraint(equalTo: skillsTitleLabel.bottomAnchor, constant: 5).isActive = true
	}
}
