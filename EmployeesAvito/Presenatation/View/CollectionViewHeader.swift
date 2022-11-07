//
//  CollectionViewHeader.swift
//  EmployeesAvito
//
//  Created by ayaz on 07.11.2022.
//

import UIKit

class CollectionViewHeader: UICollectionReusableView {

    static let identifirer = String(describing: CollectionViewHeader.self)
    
    // MARK: - Private properties
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.bigTextFont
        label.textColor = Constants.textColor
        return label
    }()
    
    private lazy var roundedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Constants.thridBackgroundColor
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 10)
        view.layer.shadowRadius = 5
        view.layer.cornerRadius = Constants.cornerRadius
        return view
    }()
    
    // MARK: - Public methods
    
    func configurate(text: String) {
        label.text = text
        
        self.addSubview(roundedView)
        roundedView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        roundedView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        roundedView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        roundedView.widthAnchor.constraint(greaterThanOrEqualTo: self.widthAnchor, multiplier: 1 / 3).isActive = true
        
        roundedView.addSubview(label)
        label.centerXAnchor.constraint(equalTo: roundedView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: roundedView.centerYAnchor).isActive = true
    }
}
