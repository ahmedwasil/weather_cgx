//
//  ServiceTests.swift
//  weather_cgx
//
//  Created by Wasil Ahmed on 01/12/2024.
//

import XCTest
@testable import weather_cgx

final class ServiceTests: XCTestCase {
    // Test for geocoding service success
    func testGeocodingService_Success() async throws {
        // Setup
        let mockService = MockWeatherService()
        mockService.mockCoordinates = GeocodeResponse(lat: "51.5074", lon: "-0.1278")
        
        // Act
        let result = try await mockService.getCoordinates(for: "London")
        
        // Assert
        XCTAssertEqual(result.lat, "51.5074")
        XCTAssertEqual(result.lon, "-0.1278")
    }
    
    // Test for geocoding service failure
    func testGeocodingService_Failure() async throws {
        // Setup
        let mockService = MockWeatherService()
        mockService.shouldThrowError = true

        do {
            // Act
            _ = try await mockService.getCoordinates(for: "InvalidLocation")
            XCTFail("Expected WeatherAppError, but no error was thrown.")
        } catch let error as WeatherAppError {
            // Assert
            XCTAssertEqual(error, .apiError("No geocode results found."))
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
    
    // Test for weather service success
    func testWeatherService_Success() async throws {
        // Setup
        let mockService = MockWeatherService()
        mockService.mockWeather = Weather(
            temperature: 20.0,
            apparentTemperature: 18.5,
            rain: 1.0,
            cloudCover: 50,
            windSpeed: 10.0,
            windDirection: 180.0,
            windGusts: 12.0
        )
        
        // Act
        let result = try await mockService.getCurrentWeather(lat: 51.5074, lon: -0.1278)
        
        // Assert
        XCTAssertEqual(result.temperature, 20.0)
        XCTAssertEqual(result.apparentTemperature, 18.5)
        XCTAssertEqual(result.rain, 1.0)
        XCTAssertEqual(result.cloudCover, 50)
        XCTAssertEqual(result.windSpeed, 10.0)
        XCTAssertEqual(result.windDirection, 180.0)
        XCTAssertEqual(result.windGusts, 12.0)
    }
    
    // Test for weather service failure
    func testWeatherService_Failure() async throws {
        // Setup
        let mockService = MockWeatherService()
        mockService.shouldThrowError = true
        
        do {
            // Act
            _ = try await mockService.getCurrentWeather(lat: 0.0, lon: 0.0)
            XCTFail("Expected WeatherAppError, but no error was thrown.")
        } catch let error as WeatherAppError {
            // Assert
            XCTAssertEqual(error, .apiError("Unable to fetch weather data."))
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
}
