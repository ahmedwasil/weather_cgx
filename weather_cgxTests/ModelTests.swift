//
//  ModelTests.swift
//  weather_cgx
//
//  Created by Wasil Ahmed on 30/11/2024.
//

import XCTest
@testable import weather_cgx

final class ModelTests: XCTestCase {
    
    // Test decoding GeocodeResponse
    func testGeocodeResponse() throws {
        // Setup
        let mockGeocodeJSON = """
        [
            {
                "lat": "51.5074",
                "lon": "-0.1278"
            }
        ]
        """.data(using: .utf8)!

        // Act
        let geocodeResults = try JSONDecoder().decode([GeocodeResponse].self, from: mockGeocodeJSON)
        
        // Assert
        XCTAssertEqual(geocodeResults.first?.lat, "51.5074")
        XCTAssertEqual(geocodeResults.first?.lon, "-0.1278")
    }

    // Test decoding WeatherResponse
    func testWeatherResponse() throws {
        // Setup
        let mockWeatherJSON = """
        {
            "latitude": 51.5074,
            "longitude": -0.1278,
            "current": {
                "temperature_2m": 15.3,
                "apparent_temperature": 14.8,
                "rain": 0.0,
                "cloud_cover": 75,
                "wind_speed_10m": 5.4,
                "wind_direction_10m": 90,
                "wind_gusts_10m": 7.8
            }
        }
        """.data(using: .utf8)!
        
        // Act
        let weatherResult = try JSONDecoder().decode(WeatherResponse.self, from: mockWeatherJSON)
        
        // Assert
        XCTAssertEqual(weatherResult.latitude, 51.5074)
        XCTAssertEqual(weatherResult.longitude, -0.1278)
        XCTAssertEqual(weatherResult.current.temperature, 15.3)
        XCTAssertEqual(weatherResult.current.apparentTemperature, 14.8)
        XCTAssertEqual(weatherResult.current.rain, 0.0)
        XCTAssertEqual(weatherResult.current.cloudCover, 75)
        XCTAssertEqual(weatherResult.current.windSpeed, 5.4)
        XCTAssertEqual(weatherResult.current.windDirection, 90)
        XCTAssertEqual(weatherResult.current.windGusts, 7.8)
    }

    // Test decoding WeatherResponse with missing fields
    func testWeatherResponse_MissingFields() {
        // Setup
        let incompleteWeatherJSON = """
        {
            "latitude": 51.5074,
            "longitude": -0.1278,
            "current": {
                "temperature_2m": 15.3,
                "apparent_temperature": 14.8
            }
        }
        """.data(using: .utf8)!

        // Act & Assert
        XCTAssertThrowsError(try JSONDecoder().decode(WeatherResponse.self, from: incompleteWeatherJSON)) { error in
            if case DecodingError.keyNotFound(let key, let context) = error {
                XCTAssertEqual(key.stringValue, "rain") // First missing key
                XCTAssertEqual(context.codingPath.map(\.stringValue), ["current"])
            } else {
                XCTFail("Expected keyNotFound error for missing field, got: \(error)")
            }
        }
    }
}
