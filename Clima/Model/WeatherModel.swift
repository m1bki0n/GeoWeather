//
//  WeatherModel.swift
//  Clima
//
//  Created by Makwan BK on 3/19/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let tempurature: Double
    
    var conditionName: String {
        return getWeatherName(weatherId: conditionId)
    }
    
    var tempDecimalRemovable: String {
        return String(format: "%.0f", tempurature)
    }
    
    func getWeatherName(weatherId: Int) -> String {
        
        switch weatherId {
            
        case 200...232:
            return "cloud.bolt.rain"
        case 300...321:
            return "cloud.rain"
        case 500...504:
            return "cloud.sun.rain"
        case 511:
            return "snow"
        case 520...531:
            return "cloud.bolt.rain"
        case 600...622:
            return "snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801:
            return "cloud.sun"
        case 802:
            return "cloud"
        case 803...804:
            return "smoke"
        default:
            return "sun"
            
        }
        
    }
}
