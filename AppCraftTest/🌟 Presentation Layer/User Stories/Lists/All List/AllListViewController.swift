//
//  AllListViewController.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 25.02.2021.
//  Copyright © 2021 AppCraft. All rights reserved.
//

import GKViper
import GKRepresentable

protocol AllListViewInput: ViperViewInput {
    func reloadTable(with cells: [TableCellModel])
    func noConnection()
}

protocol AllListViewOutput: ViperViewOutput {
    func refreshData()
    func showDetails(for url: String)
    func savePokemon(from url: String)
}

class AllListViewController: ViperViewController {
    // MARK: - Outlets
    @IBOutlet weak var tableVw: UITableView!
    
    // MARK: - Props
    private let refreshController = UIRefreshControl()
    private var rows : [TableCellModel] = []
    var noConnectionView: NoConnectionView?
    
    fileprivate var output: AllListViewOutput? {
        guard let output = self._output as? AllListViewOutput else { return nil }
        return output
    }
    
    // MARK: - Lifecycle
    override func viewDidLayoutSubviews() {
        self.applyStyles()
    }
    
    // MARK: - Setup functions
    func setupComponents() {
        self.navigationItem.title = AppLocalization.Titles.remoteList.localized
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.setupTableView()
    }
    
    func setupActions() { }
    
    func applyStyles() { }
    
    // MARK: - AllListViewInput
    override func setupInitialState(with viewModel: ViperViewModel) {
        super.setupInitialState(with: viewModel)
        
        self.setupComponents()
        self.setupActions()
    }
    
}

// MARK: - AllListViewInput
extension AllListViewController: AllListViewInput {
    func reloadTable(with cells: [TableCellModel]) {
        self.rows = cells
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableVw.reloadData()
        }
    }
    
    func noConnection() {
        self.noConnectionView = NoConnectionView.loadNib()
        guard let noConnectionView = self.noConnectionView else { return }
        var model = NoConnectionViewModel()
        model.didAction = { [weak self] (v,_) in
            v.removeFromSuperview()
            self?.noConnectionView = nil
            self?.output?.refreshData()
        }
        noConnectionView.setup(model: model)
        view.addSubview(noConnectionView)
        noConnectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([noConnectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     noConnectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     noConnectionView.topAnchor.constraint(equalTo: view.topAnchor),
                                     noConnectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        
    }
}

// MARK: - Actions
extension AllListViewController {
    @objc
    func refreshList() {
        output?.refreshData()
        self.refreshController.perform(#selector(UIRefreshControl.endRefreshing), with: nil, afterDelay: 0)
    }
}


extension AllListViewController: UITableViewDelegate, UITableViewDataSource {
    private func setupTableView() {
        self.tableVw.delegate = self
        self.tableVw.dataSource = self
        self.tableVw.separatorStyle = .none
        self.tableVw.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        self.refreshController.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        self.tableVw.refreshControl = self.refreshController
        self.tableVw.registerCellNib(PokemonTableCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = rows[indexPath.row]
        guard !model.cellIdentifier.isEmpty,
              let cell = tableView.dequeueReusableCell(withIdentifier: model.cellIdentifier, for: indexPath) as? PokemonTableCell  else { return UITableViewCell() }
        cell.model = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = self.rows[indexPath.row] as? PokemonTableCellModel else { return }
        self.output?.showDetails(for: model.url)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Save") { (action, view, completionHandler) in
            guard let model = self.rows[indexPath.row] as? PokemonTableCellModel else { return }
            self.output?.savePokemon(from: model.url)
            completionHandler(true)
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}
