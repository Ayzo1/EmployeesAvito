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
	
	private lazy var collectionView: UICollectionView = {
		let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: createLayout())
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.showsVerticalScrollIndicator = false
		collectionView.register(EmployeeCollectionViewCell.self, forCellWithReuseIdentifier: EmployeeCollectionViewCell.identifirer)
		collectionView.backgroundColor = Colors.backgroundColor
		return collectionView
	}()
	
	private lazy var errorLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.backgroundColor = Colors.errorColor
		label.textColor = Colors.textColor
		label.font = .monospacedDigitSystemFont(ofSize: 20, weight: .medium)
		label.textAlignment = .center
		return label
	}()
	
	private lazy var updateButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Обновить", for: .normal)
		button.backgroundColor = Colors.secondBackgroundColor
		button.setTitleColor(Colors.textColor, for: .normal)
		button.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
		button.layer.cornerRadius = 20
		button.addTarget(self, action: #selector(refreshCollectionView), for: .touchUpInside)
		return button
	}()
	
	private lazy var refreshControl: UIRefreshControl = {
		let refreshControl = UIRefreshControl()
		refreshControl.addTarget(self, action: #selector(refreshCollectionView), for: .valueChanged)
		return refreshControl
	}()
	
	// MARK: - Lifecycle
	
    override func viewDidLoad() {
        super.viewDidLoad()
		guard let presenter: EmployeesPresenterProtocol = ServiceLocator.shared.resolve() else {
			return
		}
		self.presenter = presenter
		view.backgroundColor = Colors.backgroundColor
		collectionView.refreshControl = refreshControl
		collectionView.delegate = self
		collectionView.dataSource = self
		setupSubviews()
		setTitle()
    }

	// MARK: - EmployeesViewProtocol
	
	func updateData() {
		DispatchQueue.main.async { [weak self] in
			self?.setTitle()
			self?.collectionView.reloadData()
			self?.errorLabel.removeFromSuperview()
			self?.updateButton.removeFromSuperview()
			self?.refreshControl.endRefreshing()
		}
	}
	
	func showError(message: String) {
		DispatchQueue.main.async { [weak self] in
			guard let self = self else {
				return
			}
			self.errorLabel.text = message
			self.setupErrorLabel()
			self.refreshControl.endRefreshing()
			if (self.presenter?.getEmployeesCount(for: 0) ?? 0) < 1 {
				self.setupUpdateButton()
			}
		}
	}
	
	// MARK: - Private methods
	
	private func setupUpdateButton() {
		view.addSubview(updateButton)
		updateButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
		updateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		updateButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
		updateButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
		
	}
	
	private func setTitle() {
		guard let title = presenter?.getCompanyName() else {
			navigationItem.title = ""
			return
		}
		navigationItem.title = title
	}
	
	private func setupErrorLabel() {
		view.addSubview(errorLabel)
		errorLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
		errorLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
		errorLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
		errorLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
	}
	
	private func setupSubviews() {
		setupNavigationController()
		view.addSubview(collectionView)
		collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
		collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
		collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
		collectionView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
		collectionView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
	}
	
	private func setupNavigationController() {
		navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Colors.darkTextColor]
		navigationController?.navigationBar.barTintColor = Colors.backgroundColor
		navigationController?.navigationBar.isTranslucent = true
	}
	
	private func createLayout() -> UICollectionViewCompositionalLayout {
		let layout = UICollectionViewCompositionalLayout { (section, layoutEnvironment) -> NSCollectionLayoutSection? in
			let itemSize = NSCollectionLayoutSize( widthDimension: .fractionalWidth(1), heightDimension: .absolute(120))
			let item = NSCollectionLayoutItem(layoutSize: itemSize)
			item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
			let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120))
			let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
			let section = NSCollectionLayoutSection(group: group)
			section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
			return section
		}
		return layout
	}
	
	// MARK: - @objc private methods
	
	@objc private func refreshCollectionView() {
		presenter?.updateCompany()
	}
}

extension EmployeesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		presenter?.getCompaniesCount() ?? 0
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return presenter?.getEmployeesCount(for: section) ?? 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmployeeCollectionViewCell.identifirer, for: indexPath) as? EmployeeCollectionViewCell else {
			return UICollectionViewCell()
		}
		let employee = presenter?.getEmployee(for: 0, employeeIndex: indexPath.row)
		cell.configurate(name: employee?.name ?? "", number: employee?.phoneNumber ?? "", skills: employee?.skills ?? [""])
		return cell
	}
}
