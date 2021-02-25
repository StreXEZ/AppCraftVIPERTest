//
//  SavedListViewController.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 25.02.2021.
//  Copyright © 2021 AppCraft. All rights reserved.
//

import GKViper

protocol SavedListViewInput: ViperViewInput { }

protocol SavedListViewOutput: ViperViewOutput { }

class SavedListViewController: ViperViewController, SavedListViewInput {

    // MARK: - Outlets
    
    // MARK: - Props
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
        self.navigationItem.title = ""
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func setupActions() { }
    
    func applyStyles() { }
    
    // MARK: - SavedListViewInput
    override func setupInitialState(with viewModel: ViperViewModel) {
        super.setupInitialState(with: viewModel)
        
        self.setupComponents()
        self.setupActions()
    }
    
}

// MARK: - Actions
extension SavedListViewController { }

// MARK: - Module functions
extension SavedListViewController { }
