//
//  WeatherViewModelTests.swift
//  weather_cgx
//
//  Created by Wasil Ahmed on 01/12/2024.
//

import XCTest
@testable import weather_cgx

final class WeatherViewModelTests: XCTestCase {
    
    func testFetchWeather_Success() async throws {
        // Setup
        let mockService = MockWeatherService()
        mockService.mockCoordinates = GeocodeResponse(lat: "51.5074", lon: "-0.1278")
        mockService.mockWeather = Weather(
            temperature: 20.0,
            apparentTemperature: 18.0,
            rain: 0.0,
            cloudCover: 50,
            windSpeed: 10.0,
            windDirection: 180.0,
            windGusts: 12.0
        )

        // ViewModel Setup
        let viewModel = await WeatherViewModel(weatherService: mockService)

        // Act
        await viewModel.fetchWeather(forLocation: "London")

        // Assert
        await MainActor.run {
            XCTAssertNotNil(viewModel.weather)
            XCTAssertEqual(viewModel.weather?.temperature, 20.0)
            XCTAssertEqual(viewModel.weather?.apparentTemperature, 18.0)
            XCTAssertEqual(viewModel.weather?.rain, 0.0)
            XCTAssertEqual(viewModel.weather?.cloudCover, 50)
            XCTAssertNil(viewModel.errorMessage)
            XCTAssertFalse(viewModel.isLoading)
        }
    }

    func testFetchWeather_InvalidLocation_Error() async throws {
        // Setup
        let mockService = MockWeatherService()
        mockService.shouldThrowError = true

        // ViewModel Setup
        let viewModel = await WeatherViewModel(weatherService: mockService)

        // Act
        await viewModel.fetchWeather(forLocation: "InvalidLocation")

        // Assert
        await MainActor.run {
            XCTAssertNil(viewModel.weather)
            XCTAssertNotNil(viewModel.errorMessage)
            XCTAssertEqual(viewModel.errorMessage, "No geocode results found.")
            XCTAssertFalse(viewModel.isLoading)
        }
    }

    func testFetchWeather_APIError() async throws {
        // Setup
        let mockService = MockWeatherService()
        mockService.shouldThrowError = true

        // ViewModel Setup
        let viewModel = await WeatherViewModel(weatherService: mockService)

        // Act
        await viewModel.fetchWeather(forLocation: "London")

        // Assert
        await MainActor.run {
            XCTAssertNil(viewModel.weather)
            XCTAssertNotNil(viewModel.errorMessage)
            XCTAssertEqual(viewModel.errorMessage, "No geocode results found.")
            XCTAssertFalse(viewModel.isLoading)
        }
    }
}

