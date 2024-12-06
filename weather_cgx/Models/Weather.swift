//
//  Weather.swift
//  weather_cgx
//
//  Created by Wasil Ahmed on 01/12/2024.
//

import Foundation

struct Weather: Codable {
    let temperature: Double
    let apparentTemperature: Double
    let rain: Double
    let cloudCover: Int
    let windSpeed: Double
    let windDirection: Double
    let windGusts: Double

    enum CodingKeys: String, CodingKey {
        case temperature = "temperature_2m"
        case apparentTemperature = "apparent_temperature"
        case rain
        case cloudCover = "cloud_cover"
        case windSpeed = "wind_speed_10m"
        case windDirection = "wind_direction_10m"
        case windGusts = "wind_gusts_10m"
    }
}
