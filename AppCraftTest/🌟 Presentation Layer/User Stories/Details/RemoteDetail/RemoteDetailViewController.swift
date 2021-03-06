//
//  RemoteDetailViewController.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 26.02.2021.
//  Copyright © 2021 AppCraft. All rights reserved.
//

import GKViper
import GKRepresentable

protocol RemoteDetailViewInput: ViperViewInput {
    func localPokemonState(isPokeSaved: Bool)
    func updateSections(with sections: [TableSectionModel])
}

protocol RemoteDetailViewOutput: ViperViewOutput {
    func interactWithLocalDB()
}

class RemoteDetailViewController: ViperViewController {
    @IBOutlet private weak var tableVw: UITableView!
    
    // MARK: - Props
    var sections: [TableSectionModel] = []
    
    fileprivate var output: RemoteDetailViewOutput? {
        guard let output = self._output as? RemoteDetailViewOutput else { return nil }
        return output
    }
    
    // MARK: - Lifecycle
    override func viewDidLayoutSubviews() {
        self.applyStyles()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Setup functions
    func setupComponents() {
        self.navigationItem.title = AppLocalization.Titles.pokemonDetails.localized
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.setupTableView()
        self.tableVw.separatorStyle = .none
    }
    
    func setupActions() { }
    
    func applyStyles() { }
    
    // MARK: - RemoteDetailViewInput
    override func setupInitialState(with viewModel: ViperViewModel) {
        super.setupInitialState(with: viewModel)
        
        self.setupComponents()
        self.setupActions()
    }
    
}

// MARK: - Actions
extension RemoteDetailViewController { }

// MARK: - Module functions
extension RemoteDetailViewController: UITableViewDelegate, UITableViewDataSource {
    private func setupTableView() {
        self.tableVw.delegate = self
        self.tableVw.dataSource = self
        self.tableVw.registerCellNib(WeightHeightCell.self)
        self.tableVw.registerCellNib(BaseExperienceCell.self)
        self.tableVw.registerCellNib(PokemonNameCell.self)
        self.tableVw.registerCellNib(PokemonTypeCell.self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.sections[indexPath.section].rows[indexPath.row]
        
        if model is WeightHeightCellModel {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: model.cellIdentifier) as? WeightHeightCell else { return UITableViewCell() }
            cell.model = model
            return cell
        }
        if model is BaseExperienceCellModel {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: model.cellIdentifier) as? BaseExperienceCell else { return UITableViewCell() }
            cell.model = model
            return cell
        }
        
        if model is PokemonNameCellModel {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: model.cellIdentifier) as? PokemonNameCell else { return UITableViewCell() }
            cell.model = model
            return cell
        }
        
        if model is PokemonTypeCellModel {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: model.cellIdentifier) as? PokemonTypeCell else { return UITableViewCell() }
            cell.model = model
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - RemoteDetailViewInput & RemoteDetailViewOutput
extension RemoteDetailViewController: RemoteDetailViewInput {
    func localPokemonState(isPokeSaved: Bool) {
        if isPokeSaved {
            DispatchQueue.main.async { [weak self] in
                self?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: AppAssets.favourite, style: .plain, target: self, action: #selector(self?.interactWithLocalDB))
            }
        } else {
            DispatchQueue.main.async { [weak self] in
                self?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: AppAssets.notFavourite, style: .plain, target: self, action: #selector(self?.interactWithLocalDB))
            }
        }
    }
    
    @objc
    func interactWithLocalDB() {
        self.output?.interactWithLocalDB()
    }
    
    func updateSections(with sections: [TableSectionModel]) {
        self.sections = sections
        DispatchQueue.main.async { [weak self] in
            self?.tableVw.reloadData()
        }
    }
    
}
