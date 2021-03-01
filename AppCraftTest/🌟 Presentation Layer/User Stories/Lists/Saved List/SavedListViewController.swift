//
//  SavedListViewController.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 25.02.2021.
//  Copyright © 2021 AppCraft. All rights reserved.
//

import GKViper
import GKRepresentable

protocol SavedListViewInput: ViperViewInput {
    func reloadTable(with cells: [TableCellModel])
    func reloadTable()
}

protocol SavedListViewOutput: ViperViewOutput {
    func refreshData()
    func showDetails(by name: String)
    func deletePokemon(by name: String)
}

class SavedListViewController: ViperViewController, SavedListViewInput {
    // MARK: - Outlets
    @IBOutlet weak var tableVw: UITableView!
    
    // MARK: - Props
    private let refreshController = UIRefreshControl()
    private var rows : [TableCellModel] = []
    
    fileprivate var output: SavedListViewOutput? {
        guard let output = self._output as? SavedListViewOutput else { return nil }
        return output
    }
    
    // MARK: - Lifecycle
    override func viewDidLayoutSubviews() {
        self.applyStyles()
    }
    
    // MARK: - Setup functions
    func setupComponents() {
        self.navigationItem.title = "Saved Pokemons"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func setupActions() { }
    
    func applyStyles() { }
    
    // MARK: - SavedListViewInput
    override func setupInitialState(with viewModel: ViperViewModel) {
        super.setupInitialState(with: viewModel)
        setupTableView()
        self.setupComponents()
        self.setupActions()
    }
    
}

// MARK: - SavedListViewInput
extension SavedListViewController {
    func reloadTable(with cells: [TableCellModel]) {
        self.rows = cells
        print(self.rows.count)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableVw.reloadData()
        }
    }
    
    func reloadTable() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableVw.reloadData()
        }
    }
}

// MARK: - Actions
extension SavedListViewController {
    @objc
    func refreshList() {
        output?.refreshData()
        self.refreshController.perform(#selector(UIRefreshControl.endRefreshing), with: nil, afterDelay: 0)
    }
}

extension SavedListViewController: UITableViewDelegate, UITableViewDataSource {
    private func setupTableView() {
        self.tableVw.delegate = self
        self.tableVw.dataSource = self
        self.tableVw.separatorStyle = .none
        self.tableVw.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        
        self.refreshController.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        self.tableVw.refreshControl = self.refreshController
        
        self.tableVw.registerCellNib(PokemonTableCell.self)
        self.tableVw.registerCellNib(EmptyListCell.self)
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = rows[indexPath.row]
        if model is PokemonTableCellModel {
            guard !model.cellIdentifier.isEmpty,
                  let cell = tableView.dequeueReusableCell(withIdentifier: model.cellIdentifier, for: indexPath) as? PokemonTableCell  else { return UITableViewCell() }
            cell.model = model
            return cell
        }
        if model is EmptyListCellModel {
            guard !model.cellIdentifier.isEmpty,
                  let cell = tableView.dequeueReusableCell(withIdentifier: model.cellIdentifier, for: indexPath) as? EmptyListCell  else { return UITableViewCell() }
            cell.model = model
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let model = rows[indexPath.row]
        if model is PokemonTableCellModel {
            let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
                guard let model = self.rows[indexPath.row] as? PokemonTableCellModel else { return }
                self.output?.deletePokemon(by: model.name)
            }
            return UISwipeActionsConfiguration(actions: [action])
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = self.rows[indexPath.row] as? PokemonTableCellModel else { return }
        self.output?.showDetails(by: model.name)
    }
}
