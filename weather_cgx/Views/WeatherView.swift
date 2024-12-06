//
//  ContentView.swift
//  weather_cgx
//
//  Created by Wasil Ahmed on 30/11/2024.
//

import SwiftUI

struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel(
            weatherService: DefaultWeatherService(networkService: NetworkManager())
        )
    @State private var location: String = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Search Input
                TextField("Enter location (e.g., London)", text: $location)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(.none)

                // Fetch Weather Button
                Button(action: {
                    Task {
                        await viewModel.fetchWeather(forLocation: location)
                    }
                }) {
                    Text("Get Weather")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding(.horizontal)

                // Loading Indicator
                if viewModel.isLoading {
                    ProgressView("Fetching Weather...")
                        .padding()
                }

                // Weather Data or Error Message
                if let weather = viewModel.weather {
                    WeatherCardView(weather: weather)
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Weather App")
        }
    }
}

struct WeatherCardView: View {
    let weather: Weather

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Weather Details")
                .font(.headline)
                .padding(.bottom, 10)

            VStack(alignment: .leading, spacing: 8) {
                Text("🌡️ Temperature: \(String(format: "%.1f", weather.temperature))°C")
                Text("🥶 Feels Like: \(String(format: "%.1f", weather.apparentTemperature))°C")
                Text("☁️ Cloud Cover: \(weather.cloudCover)%")
                Text("🌧️ Rain: \(String(format: "%.2f", weather.rain)) mm")
                Text("💨 Wind Speed: \(String(format: "%.1f", weather.windSpeed)) mp/h")
                Text("🧭 Wind Direction: \(String(format: "%.0f", weather.windDirection))°")
                Text("🌬️ Wind Gusts: \(String(format: "%.1f", weather.windGusts)) mp/h")
            }
            .padding()
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(10)
            .shadow(radius: 5)
        }
        .padding()
    }
}


struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}

struct WeatherCardView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherCardView(weather: Weather(
            temperature: 15.0,
            apparentTemperature: 10.0,
            rain: 54.0,
            cloudCover: 4,
            windSpeed: 14.0,
            windDirection: 3.2,
            windGusts: 5.6)
        )
    }
}
