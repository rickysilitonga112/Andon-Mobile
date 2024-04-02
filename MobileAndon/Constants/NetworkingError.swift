//
//  NetworkingError.swift
//  MobileAndon
//
//  Created by Ricky Silitonga on 02/04/24.
//

import Foundation

enum FirebaseNetworkingError: Error {
    case firebaseInitializationFailed
    case authenticationError
    case networkUnavailable
    case dataParsingError
    case serverError(String) // Additional information can be provided in case of server errors
    case failedUid
    case failedToGetData(collectionName: String)
    
    var localizedDescription: String {
        switch self {
        case .firebaseInitializationFailed:
            return "Failed to initialize Firebase."
        case .authenticationError:
            return "Authentication failed."
        case .networkUnavailable:
            return "Network is unavailable."
        case .dataParsingError:
            return "Failed to parse data received from the server."
        case .serverError(let message):
            return "Server error: \(message)"
        case .failedUid:
            return "Failed to get UID."
        case .failedToGetData(let collectionName):
            return "Failed to get data from collection: \(collectionName)"
        }
    }
}
