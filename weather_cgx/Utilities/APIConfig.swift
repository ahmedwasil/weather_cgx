//
//  APIConfig.swift
//  weather_cgx
//
//  Created by Wasil Ahmed on 01/12/2024.
//

import Foundation

struct APIConfig {
    // Base URLs
    static let geocodingBaseURL = "https://geocode.maps.co/search"
    static let weatherBaseURL = "https://api.open-meteo.com/v1/forecast"
    
    // API Keys
    static let geocodingAPIKey = "674c981477af6063809654rmx45c495"

    // Build URLs
    static func buildGeocodingURL(for location: String) -> URL? {
        let encodedLocation = location.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? location
        let urlString = "\(geocodingBaseURL)?q=\(encodedLocation)&api_key=\(geocodingAPIKey)"
        return URL(string: urlString)
    }

    static func buildWeatherURL(lat: Double, lon: Double) -> URL? {
        let urlString = "\(weatherBaseURL)?latitude=\(lat)&longitude=\(lon)&wind_speed_unit=mph&current=temperature_2m,apparent_temperature,rain,cloud_cover,wind_speed_10m,wind_direction_10m,wind_gusts_10m"
        return URL(string: urlString)
    }
}
