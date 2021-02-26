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
}

protocol AllListViewOutput: ViperViewOutput { }

class AllListViewController: ViperViewController, AllListViewInput {
    // MARK: - Outlets
    @IBOutlet weak var tableVw: UITableView!
    
    // MARK: - Props
    private var rows : [TableCellModel] = []
    
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
        self.navigationItem.title = ""
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

// MARK: - Actions
extension AllListViewController {
    func reloadTable(with cells: [TableCellModel]) {
        self.rows = cells
        print(rows.count)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableVw.reloadData()
        }
    }
}

// MARK: - Module functions
extension AllListViewController { }

extension AllListViewController: UITableViewDelegate, UITableViewDataSource {
    private func setupTableView() {
        self.tableVw.delegate = self
        self.tableVw.dataSource = self
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
}
