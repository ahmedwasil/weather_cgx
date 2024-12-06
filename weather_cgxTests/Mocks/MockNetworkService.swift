//
//  MockNetworkService.swift
//  weather_cgx
//
//  Created by Wasil Ahmed on 01/12/2024.
//

import Foundation
@testable import weather_cgx

class MockNetworkService: NetworkService {
    var shouldThrowError = false
    var mockData: Data?

    func fetch<T: Decodable>(url: URL) async throws -> T {
        if shouldThrowError {
            throw WeatherAppError.networkError("Simulated network error.")
        }

        guard let data = mockData else {
            throw WeatherAppError.networkError("No mock data provided.")
        }

        return try JSONDecoder().decode(T.self, from: data)
    }
}
