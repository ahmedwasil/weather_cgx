//
//  WeatherAppError.swift
//  weather_cgx
//
//  Created by Wasil Ahmed on 01/12/2024.
//

import Foundation

enum WeatherAppError: Error, Equatable {
    case networkError(String)
    case decodingError(String)
    case apiError(String)
    case invalidInput(String)
    case unknownError

    // Equatable conformance
    static func == (lhs: WeatherAppError, rhs: WeatherAppError) -> Bool {
        switch (lhs, rhs) {
        case (.networkError(let lMessage), .networkError(let rMessage)):
            return lMessage == rMessage
        case (.decodingError(let lMessage), .decodingError(let rMessage)):
            return lMessage == rMessage
        case (.apiError(let lMessage), .apiError(let rMessage)):
            return lMessage == rMessage
        case (.invalidInput(let lMessage), .invalidInput(let rMessage)):
            return lMessage == rMessage
        case (.unknownError, .unknownError):
            return true
        default:
            return false
        }
    }
    
    // Computed property for error messages
    var errorMessage: String {
        switch self {
        case .networkError(let message),
            .decodingError(let message),
            .apiError(let message),
            .invalidInput(let message):
            return message // Return only the message itself
        case .unknownError:
            return "An unknown error occurred. Please try again."
        }
    }
    
    var exampleMessage: String {
        switch self {
        case .networkError:
            return "The Internet connection appears to be offline."
        case .decodingError:
            return "The response could not be processed due to invalid data."
        case .apiError:
            return "The server returned an error. Please try again later."
        case .invalidInput:
            return "The input provided is invalid. Please check and try again."
        case .unknownError:
            return "An unknown error occurred. Please try again."
        }
    }
}
