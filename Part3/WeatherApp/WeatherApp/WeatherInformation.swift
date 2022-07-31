//
//  WeatherInformation.swift
//  WeatherApp
//
//  Created by 김수빈 on 2022/07/25.
//

import Foundation

struct WeatherInformation: Codable{
    let weather: [Weather]
    let temp: Temp
    let name: String
    
    enum CodingKeys: String, CodingKey{
        case weather
        case temp = "main"
        case name
    }
}

struct Weather: Codable{
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Temp: Codable {
    let temp: Double
    let feelsLike: Double
    let minTemp: Double
    let maxTemp: Double
    // ✨ 서버에서 내려주는 json 키 값과 동일하지 않아도 됨
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case minTemp = "temp_min"
        case maxTemp = "temp_max"
    }
}
