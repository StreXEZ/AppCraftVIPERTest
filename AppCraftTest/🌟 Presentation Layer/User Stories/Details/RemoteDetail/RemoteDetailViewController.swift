//
//  RemoteDetailViewController.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 26.02.2021.
//  Copyright © 2021 AppCraft. All rights reserved.
//

import GKViper

protocol RemoteDetailViewInput: ViperViewInput { }

protocol RemoteDetailViewOutput: ViperViewOutput { }

class RemoteDetailViewController: ViperViewController, RemoteDetailViewInput {
    @IBOutlet weak var tableVw: UITableView!
    
    // MARK: - Props
    fileprivate var output: RemoteDetailViewOutput? {
        guard let output = self._output as? RemoteDetailViewOutput else { return nil }
        return output
    }
    
    // MARK: - Lifecycle
    override func viewDidLayoutSubviews() {
        self.applyStyles()
    }
    
    // MARK: - Setup functions
    func setupComponents() {
        self.navigationItem.title = "HAHA"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
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
extension RemoteDetailViewController { }
