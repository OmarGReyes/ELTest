//
//  RecipieCell.swift
//  ELTest
//
//  Created by Omar Gonzalez on 28/10/22.
//

import UIKit

protocol RecipieCellDelegate: AnyObject {
    func didTapCell(index: Int)
    func didTapSaveButton(recipieId: Int)
}

final class RecipieCell: UITableViewCell, CustomConfigurableCell {

    static var reuseIdentifier: String {
        return String(describing: self)
    }

    var recipieId: Int = 0

    weak var delegate: RecipieCellDelegate?

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let moreButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "ellipsis")
        button.setImage(image, for: .normal)
        button.tintColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapMoreButton), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    @objc private func didTapCell() {
        // TODO: This cell should be able to display the recipie by himself
        // in order to not create a function in Favorites and in Search
    }
    
    @objc private func didTapMoreButton() {
        delegate?.didTapSaveButton(recipieId: recipieId)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .black
        
        [nameLabel, moreButton].forEach { contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            moreButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            moreButton.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 16),
            moreButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            moreButton.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func setup(with data: DataCellViewModable) {
        guard let data = data as? RecipieCellModel else { return }
        nameLabel.text = data.recipie.title
        recipieId = data.recipie.id
    }
}
