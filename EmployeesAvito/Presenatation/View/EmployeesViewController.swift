//
//  EmployeesViewController.swift
//  EmployeesAvito
//
//  Created by ayaz on 04.11.2022.
//

import UIKit

class EmployeesViewController: UIViewController, EmployeesViewProtocol {
	
	// MARK: - Private properties

    private let headerSupplementaryViewOfKind = "header"
	private var presenter: EmployeesPresenterProtocol?
	
	private lazy var collectionView: UICollectionView = {
		let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: createLayout())
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.showsVerticalScrollIndicator = false
		collectionView.register(EmployeeCollectionViewCell.self, forCellWithReuseIdentifier: EmployeeCollectionViewCell.identifirer)
        collectionView.register(CollectionViewHeader.self, forSupplementaryViewOfKind: headerSupplementaryViewOfKind, withReuseIdentifier: CollectionViewHeader.identifirer)
		collectionView.backgroundColor = Constants.backgroundColor
		return collectionView
	}()
	
	private lazy var errorLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = Constants.textColor
        label.font = Constants.bigTextFont
		label.textAlignment = .center
		return label
	}()
    
    private lazy var errorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Constants.errorColor
        view.layer.cornerRadius = Constants.cornerRadius
        return view
    }()
	
	private lazy var updateButton: UIButton = {
        let button = UIButton(type: .system)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Обновить", for: .normal)
		button.backgroundColor = Constants.secondBackgroundColor
		button.setTitleColor(Constants.textColor, for: .normal)
        button.titleLabel?.font = Constants.bigTextFont
        button.layer.cornerRadius = Constants.cornerRadius
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
		view.backgroundColor = Constants.backgroundColor
		collectionView.refreshControl = refreshControl
		collectionView.delegate = self
		collectionView.dataSource = self
		setupSubviews()
		setTitle()
    }

	// MARK: - EmployeesViewProtocol
	
	func updateData() {
		DispatchQueue.main.async { [weak self] in
			self?.collectionView.reloadData()
			self?.errorView.removeFromSuperview()
			self?.updateButton.removeFromSuperview()
			self?.refreshControl.endRefreshing()
            self?.collectionView.isUserInteractionEnabled = true
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
                self.collectionView.isUserInteractionEnabled = false
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
		navigationItem.title = "Employees"
	}
	
	private func setupErrorLabel() {
        view.addSubview(errorView)
        errorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        errorView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        errorView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        errorView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        errorView.addSubview(errorLabel)
        errorLabel.centerXAnchor.constraint(equalTo: errorView.centerXAnchor).isActive = true
        errorLabel.centerYAnchor.constraint(equalTo: errorView.centerYAnchor).isActive = true
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
		navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Constants.darkTextColor]
		navigationController?.navigationBar.barTintColor = Constants.backgroundColor
		navigationController?.navigationBar.isTranslucent = true
	}
	
	private func createLayout() -> UICollectionViewCompositionalLayout {
		let layout = UICollectionViewCompositionalLayout { (section, layoutEnvironment) -> NSCollectionLayoutSection? in
			let itemSize = NSCollectionLayoutSize( widthDimension: .fractionalWidth(1), heightDimension: .absolute(120))
			let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = .zero
			let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120))
			let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
			let section = NSCollectionLayoutSection(group: group)
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60)), elementKind: self.headerSupplementaryViewOfKind, alignment: .top)
            section.boundarySupplementaryItems = [header]
			section.contentInsets = .zero
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: headerSupplementaryViewOfKind, withReuseIdentifier: CollectionViewHeader.identifirer, for: indexPath) as? CollectionViewHeader,
              let text = presenter?.getCompanyName()
        else {
            return UICollectionReusableView()
        }
        
        header.configurate(text: text)
        return header
    }
}
