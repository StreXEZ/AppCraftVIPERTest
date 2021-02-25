//
//  AppCraftTestRepository.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 25.02.2021.
//  Copyright © 2021 AppCraft. All rights reserved.
//

import GKUseCase

public class AppCraftTestRepository: Repository {
    
    init() {
        super.init(modelName: AppConfiguration.databaseContainerName)
    }
}
