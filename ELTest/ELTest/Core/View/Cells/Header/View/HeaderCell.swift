//
//  HeaderCell.swift
//  ELTest
//
//  Created by Omar Gonzalez on 28/10/22.
//

import UIKit

// MARK: HeaderCell
final class HeaderCell: UITableViewHeaderFooterView, CustomConfigurableCell {
    
    // MARK: - Properties
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initializers
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    // MARK: setupUI
    private func setupUI() {
        contentView.addSubview(label)
        let leading = label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        let centerY = label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        
        NSLayoutConstraint.activate([
            leading, centerY
        ])
    }
    
    // MARK: setup with DataCellViewModel
    func setup(with data: DataCellViewModable) {
        guard let data = data as? HeaderCellModel else { return }
        label.text = data.title
    }
    
    // MARK: setup with Text
    func setup(text: String) {
      self.label.text = text
      self.contentView.backgroundColor = .clear
    }
}

