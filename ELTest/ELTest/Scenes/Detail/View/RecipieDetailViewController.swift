//
//  DetailViewController.swift
//  ELTest
//
//  Created by Omar Gonzalez on 31/10/22.
//


import UIKit

final class RecipieDetailViewController: UIViewController {
    
    private var viewModel: RecipieDetailViewModel!
    
    convenience init(viewModel: RecipieDetailViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    private lazy var recipieTitle: UILabel = {
        let label = UILabel()
        label.text = viewModel.recipieDetail.title
        label.textColor = .black
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
//
    private lazy var recipieImage: UIImageView = {
        guard let imageURL = viewModel.recipieDetail.image,
              let url = URL(string: imageURL) else {
            return UIImageView(image: UIImage(named: "randomImage"))
        }
        let recipieImage = UIImageView()
        recipieImage.load(url: url)
        recipieImage.translatesAutoresizingMaskIntoConstraints = false
        return recipieImage
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        [recipieTitle, recipieImage].forEach { view.addSubview($0) }
        NSLayoutConstraint.activate([
            recipieTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            recipieTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            recipieTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16),
            recipieImage.topAnchor.constraint(equalTo: recipieTitle.bottomAnchor, constant: 25),
            recipieImage.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
