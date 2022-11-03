//
//  FavoritesViewController.swift
//  ELTest
//
//  Created by Omar Gonzalez on 31/10/22.
//

import UIKit
import Combine

// MARK: FavoritesViewController
final class FavoritesViewController: UIViewController {
    
    // MARK: - Properties
    private var viewModel: FavoritesViewModel!
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Initializer
    convenience init(viewModel: FavoritesViewModel) {
        self.init()
        self.viewModel = viewModel
    }
   
    // MARK: - Private properties
    private lazy var tableFooterView: UIView = {
        let tableFooterView = UIView()
        tableFooterView.backgroundColor = .black
        return tableFooterView
    }()
    
    private lazy var favoritestitle: UILabel = {
        let label = UILabel()
        label.text = "Favorites"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.delegate = self
        tableView.dataSource = self
        tableView.insetsContentViewsToSafeArea = true
        tableView.contentInsetAdjustmentBehavior = .automatic
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.addSubview(favoritestitle)
        setupTableView()
        bind()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
//        tableView.frame = view.bounds
        setupUI()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            favoritestitle.topAnchor.constraint(equalTo: margins.topAnchor, constant: 15),
            favoritestitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.topAnchor.constraint(equalTo: favoritestitle.bottomAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    private func setupTableView() {
        tableView.register(RecipieCell.self, forCellReuseIdentifier: RecipieCell.reuseIdentifier)
        tableView.register(HeaderCell.self, forHeaderFooterViewReuseIdentifier: HeaderCell.reuseIdentifier)
    }
    
    private func bind() {
        viewModel
            .$sections
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }.store(in: &subscriptions)
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sections?[section].items.count ?? Int.zero
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections?.count ?? Int.zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let currentObject: DataCellViewModable = viewModel.sections?[indexPath.section].items[indexPath.row],
              let currentCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: currentObject.reuseIdentifier) else {
                  let cell: UITableViewCell = UITableViewCell()
                  return cell
              }
        
        (currentCell as? CustomConfigurableCell)?.setup(with: currentObject)
        (currentCell as? RecipieCell)?.delegate = self
        return currentCell
    }
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didTapRecipie(indexPath.row, from: self)
    }
}

// MARK: - SongCellDelegate
extension FavoritesViewController: RecipieCellDelegate {
    func didTapCell(index: Int) {
        // Do nothing
    }
    
    func didTapSaveButton(recipieId: Int) {
        displayDeleteAlert(recipieId: recipieId)
    }
}

// MARK: - FavoritesViewController + Alerts
extension FavoritesViewController {
    private func displayDeleteAlert(recipieId: Int) {
        let alert: UIAlertController = UIAlertController(title: "Delete recipie from favorites",
                                                         message: "Do you wanna delete this recipie from favorites?",
                                                         preferredStyle: .alert)
        let deleteAction: UIAlertAction = UIAlertAction(title: "Delete", style: .default, handler: { [weak self] _ in
            self?.viewModel.deleteRecipie(recipieId: recipieId)
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}
