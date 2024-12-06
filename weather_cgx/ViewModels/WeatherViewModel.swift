//
//  WeatherViewModel.swift
//  weather_cgx
//
//  Created by Wasil Ahmed on 01/12/2024.
//

import Foundation

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var weather: Weather?
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false

    private let weatherService: WeatherService

    init(weatherService: WeatherService) {
        self.weatherService = weatherService
    }

    func fetchWeather(forLocation location: String) async {
        isLoading = true
        errorMessage = nil
        weather = nil

        defer { isLoading = false }

        do {
            let coordinates = try await weatherService.getCoordinates(for: location)
            weather = try await weatherService.getCurrentWeather(
                lat: Double(coordinates.lat) ?? 0.0,
                lon: Double(coordinates.lon) ?? 0.0
            )
        } catch let error as WeatherAppError {
            //print("WeatherAppError: \(error.errorMessage)")
            errorMessage = error.exampleMessage
        } catch {
            //print("Unexpected Error: \(error.localizedDescription)")
            errorMessage = "An unexpected error occurred. Please try again."
        }
    }
}



