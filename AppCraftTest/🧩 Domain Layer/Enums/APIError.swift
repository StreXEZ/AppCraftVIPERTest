//
//  APIError.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 01.03.2021.
//

import Foundation

enum APIError: Error {
    case noConnection
    case not200Response
    case cannotCreateRequest
    case cannotConvertData
}
