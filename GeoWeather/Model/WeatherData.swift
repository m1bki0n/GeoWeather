//
//  WeatherData.swift
//  Clima
//
//  Created by Makwan BK on 3/18/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let list: [List]
}

struct List: Codable {
    let name: String
    let id: Int
    let main: Main
    let weather : [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id : Int
    let description: String
    let main: String
}
