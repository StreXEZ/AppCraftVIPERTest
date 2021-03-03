//
//  LocalDetailViewController.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 26.02.2021.
//  Copyright © 2021 AppCraft. All rights reserved.
//

import GKViper
import GKRepresentable

protocol LocalDetailViewInput: ViperViewInput {
    func updateSections(with sections: [TableSectionModel])
}

protocol LocalDetailViewOutput: ViperViewOutput {
    func deletePokemon()
}

class LocalDetailViewController: ViperViewController {
    // MARK: - Outlets
    @IBOutlet private weak var tableVw: UITableView!
    
    // MARK: - Props
    var sections: [TableSectionModel] = []
    
    fileprivate var output: LocalDetailViewOutput? {
        guard let output = self._output as? LocalDetailViewOutput else { return nil }
        return output
    }
    
    // MARK: - Lifecycle
    override func viewDidLayoutSubviews() {
        self.applyStyles()
    }
    
    // MARK: - Setup functions
    func setupComponents() {
        self.navigationItem.title = AppLocalization.Titles.pokemonDetails.localized
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: AppAssets.favourite, style: .plain, target: self, action: #selector(deletePokemon))
        self.navigationItem.largeTitleDisplayMode = .always
        self.setupTableView()
    }
    
    func setupActions() { }
    
    func applyStyles() { }
    
    override func setupInitialState(with viewModel: ViperViewModel) {
        super.setupInitialState(with: viewModel)
        
        self.setupComponents()
        self.setupActions()
    }
    
}

// MARK: - Input
extension LocalDetailViewController: LocalDetailViewInput {
    func updateSections(with sections: [TableSectionModel]) {
        self.sections = sections
        DispatchQueue.main.async { [weak self] in
            self?.tableVw.reloadData()
        }
    }
}

// MARK: - Actions
extension LocalDetailViewController {
    @objc
    func deletePokemon() {
        self.output?.deletePokemon()
    }
}


extension LocalDetailViewController: UITableViewDelegate, UITableViewDataSource {
    private func setupTableView() {
        self.tableVw.delegate = self
        self.tableVw.dataSource = self
        self.tableVw.separatorStyle = .none
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
