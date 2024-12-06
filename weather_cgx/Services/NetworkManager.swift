//
//  NetworkManager.swift
//  weather_cgx
//
//  Created by Wasil Ahmed on 01/12/2024.
//

import Foundation

// MARK: - Protocol for Dependency Injection
protocol NetworkService {
    func fetch<T: Decodable>(url: URL) async throws -> T
}

// MARK: - Network Manager Implementation
class NetworkManager: NetworkService {
    func fetch<T: Decodable>(url: URL) async throws -> T {
        do {
            // Fetch the data and validate HTTP response
            let (data, response) = try await URLSession.shared.data(from: url)

            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                throw WeatherAppError.apiError("HTTP Error: \(httpResponse.statusCode)")
            }

            // Decode the data
            return try JSONDecoder().decode(T.self, from: data)

        } catch let decodingError as DecodingError {
            // Decoding-specific errors
            throw WeatherAppError.decodingError("Failed to decode the response: \(decodingError.localizedDescription)")

        } catch let urlError as URLError {
            // Low-level network errors
            throw WeatherAppError.networkError("Network error: \(urlError.localizedDescription)")

        } catch {
            // Catch any other unexpected errors
            throw WeatherAppError.unknownError
        }
    }
}


