//
//  WeatherResponse.swift
//  weather_cgx
//
//  Created by Wasil Ahmed on 30/11/2024.
//

import Foundation

struct WeatherResponse: Codable {
    let latitude: Double
    let longitude: Double
    let current: Weather
}
