//
//  MockWeatherService.swift
//  weather_cgx
//
//  Created by Wasil Ahmed on 01/12/2024.
//

import Foundation
@testable import weather_cgx

class MockWeatherService: WeatherService {
    var mockCoordinates: GeocodeResponse?
    var mockWeather: Weather?
    var shouldThrowError = false

    // Simulate getting coordinates
    func getCoordinates(for location: String) async throws -> GeocodeResponse {
        if shouldThrowError {
            throw WeatherAppError.apiError("No geocode results found.")
        }

        guard let coordinates = mockCoordinates else {
            throw WeatherAppError.apiError("No mock coordinates provided.")
        }

        return coordinates
    }

    // Simulate fetching weather data
    func getCurrentWeather(lat: Double, lon: Double) async throws -> Weather {
        if shouldThrowError {
            throw WeatherAppError.apiError("Unable to fetch weather data.")
        }

        guard let weather = mockWeather else {
            throw WeatherAppError.apiError("No mock weather data provided.")
        }

        return weather
    }
}
