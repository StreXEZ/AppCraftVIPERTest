//
//  LocalDetailViewController.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 26.02.2021.
//  Copyright © 2021 AppCraft. All rights reserved.
//

import GKViper

protocol LocalDetailViewInput: ViperViewInput { }

protocol LocalDetailViewOutput: ViperViewOutput { }

class LocalDetailViewController: ViperViewController, LocalDetailViewInput {

    // MARK: - Outlets
    
    // MARK: - Props
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
        self.navigationItem.title = ""
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: AppAssets.favourite, style: .plain, target: self, action: #selector(deletePokemon))
    }
    
    func setupActions() { }
    
    func applyStyles() { }
    
    // MARK: - LocalDetailViewInput
    override func setupInitialState(with viewModel: ViperViewModel) {
        super.setupInitialState(with: viewModel)
        
        self.setupComponents()
        self.setupActions()
    }
    
}

// MARK: - Actions
extension LocalDetailViewController {
    @objc
    func deletePokemon() {
        print("DELETE")
    }
}

// MARK: - Module functions
extension LocalDetailViewController { }
