//
//  WeatherService.swift
//  weather_cgx
//
//  Created by Wasil Ahmed on 01/12/2024.
//

import Foundation

// MARK: - Protocol
protocol WeatherService {
    func getCoordinates(for location: String) async throws -> GeocodeResponse
    func getCurrentWeather(lat: Double, lon: Double) async throws -> Weather
}

// MARK: - Implementation
class DefaultWeatherService: WeatherService {
    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func getCoordinates(for location: String) async throws -> GeocodeResponse {
        guard let url = APIConfig.buildGeocodingURL(for: location) else {
            throw WeatherAppError.invalidInput("Invalid location input.")
        }

        print("Geocoding URL: \(url)")
        let geocodeResults: [GeocodeResponse] = try await networkService.fetch(url: url)
        //print("Geocode Results Count: \(geocodeResults.count)")
        
        if geocodeResults.isEmpty {
            throw WeatherAppError.apiError("No results found for '\(location)'. Please refine your search.")
        }

        // Ensure at least one result exists
        guard let firstResult = geocodeResults.first else {
            throw WeatherAppError.apiError("No geocode results found.")
        }

        return firstResult
    }

    func getCurrentWeather(lat: Double, lon: Double) async throws -> Weather {
        guard let url = APIConfig.buildWeatherURL(lat: lat, lon: lon) else {
            throw WeatherAppError.invalidInput("Invalid coordinates.")
        }

        print("Weather URL: \(url)")

        do {
            let response: WeatherResponse = try await networkService.fetch(url: url)
            return response.current
        } catch let error as WeatherAppError {
            throw error
        } catch {
            throw WeatherAppError.unknownError
        }
    }
}
