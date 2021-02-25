//
//  AllListViewController.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 25.02.2021.
//  Copyright © 2021 AppCraft. All rights reserved.
//

import GKViper
import GKRepresentable

protocol AllListViewInput: ViperViewInput { }

protocol AllListViewOutput: ViperViewOutput { }

class AllListViewController: ViperViewController, AllListViewInput {

    // MARK: - Outlets
    @IBOutlet weak var tableVw: UITableView!
    
    // MARK: - Props
    private var rows : [TableCellIdentifiable] = []
    
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
extension AllListViewController { }

// MARK: - Module functions
extension AllListViewController { }

extension AllListViewController: UITableViewDelegate, UITableViewDataSource {
    private func setupTableView() {
        self.tableVw.delegate = self
        self.tableVw.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}
