//
//  SearchRecipieViewController.swift
//  ELTest
//
//  Created by Omar Gonzalez on 28/10/22.
//

import Combine
import UIKit

protocol SearchRecipieViewControllerDelegate: AnyObject {
    func addRecipieToFavorites(recipie: Recipie)
}

final class SearchRecipieViewController: UIViewController {
    // MARK: - Properties
    private var viewModel: SearchRecipieViewModel!
    private var subscriptions = Set<AnyCancellable>()
    private var activityView: UIActivityIndicatorView?
    
    // MARK: - Delegate
    weak var delegate: SearchRecipieViewControllerDelegate?
    
    private var tableFooterView: UIView {
        let tableFooterView = UIView()
        tableFooterView.backgroundColor = .black
        return tableFooterView
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.delegate = self
        tableView.dataSource = self
        tableView.insetsContentViewsToSafeArea = true
        tableView.contentInsetAdjustmentBehavior = .automatic
        return tableView
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Search by key word"
        searchBar.searchTextField.backgroundColor = .white
        searchBar.tintColor = .black
        return searchBar
    }()
    
    // MARK: - Initializer
    convenience init(viewModel: SearchRecipieViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        setupTableView()
        setupNavigationItem()
        setupLayout()
        bind()
    }
    

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }

    // MARK: setupNavigationItem
    private func setupNavigationItem() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
    }
    
    private func setupLayout() {
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: margins.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.register(HeaderCell.self, forHeaderFooterViewReuseIdentifier: HeaderCell.reuseIdentifier)
        tableView.register(RecipieCell.self, forCellReuseIdentifier: RecipieCell.reuseIdentifier)
    }
    
    // MARK: bind
    private func bind() {
        viewModel
            .$sections
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
                self?.hideActivityIndicator()
            }.store(in: &subscriptions)
        
        viewModel.errorClosure = { [weak self] in
            self?.displayErrorAlert()
        }
        
        viewModel.finishLoad = { [weak self] in
            self?.hideActivityIndicator()
        }
    }
    
    // MARK: displaySaveAlert
    private func displaySaveAlert(recipie: Recipie) {
        let alert: UIAlertController = UIAlertController(title: "Add to favorites",
                                                         message: "Do you wanna add this recipie to favorites?",
                                                         preferredStyle: .alert)
        let acceptAction: UIAlertAction = UIAlertAction(title: "Ok", style: .default, handler: { [weak self] _ in
            self?.delegate?.addRecipieToFavorites(recipie: recipie)
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alert.addAction(acceptAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func displayErrorAlert() {
        let alert: UIAlertController = UIAlertController(title: "Network Error",
                                                         message: "Sorry, try again.",
                                                         preferredStyle: .alert)
        let cancelAction: UIAlertAction = UIAlertAction(title: "Acept", style: .default, handler: nil)
        
        alert.addAction(cancelAction)
        hideActivityIndicator()
        present(alert, animated: true, completion: nil)
    }

    private func showActivityIndicator() {
        activityView = UIActivityIndicatorView(style: .large)
        activityView?.color = .white
        activityView?.center = self.view.center
        self.view.addSubview(activityView!)
        activityView?.startAnimating()
    }

    private func hideActivityIndicator(){
        if (activityView != nil) {
            activityView?.stopAnimating()
        }
    }
}

// MARK: - UISearchBarDelegate
extension SearchRecipieViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
                let searchTerm = searchBar.text ?? ""
                viewModel?.keyWordInput = searchTerm
        showActivityIndicator()
                self.searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.keyWordInput = ""
        self.searchBar.endEditing(true)
    }
}

// MARK: - UITableViewDataSource
extension SearchRecipieViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sections?.count ?? Int.zero
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.sections?[section].items.count ?? Int.zero
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

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionTitle : String = viewModel.sections?[section].title,
              let sectionView: HeaderCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderCell.reuseIdentifier) as? HeaderCell
        else { return  nil }
        
        sectionView.setup(text: sectionTitle)
        return sectionView
    }
}

// MARK: - UITableViewDelegate
extension SearchRecipieViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showActivityIndicator()
        viewModel.didTapRecipie(viewModel.recipies[indexPath.row].id, from: self)
    }
}

extension SearchRecipieViewController: RecipieCellDelegate {
    func didTapCell(index: Int) {
        // TODO: Do nothing
    }
    
    func didTapSaveButton(recipieId: Int) {
        guard let recipie = viewModel.searchRecipieById(recipieId: recipieId) else {
            return
        }
        displaySaveAlert(recipie: recipie)
    }
}
