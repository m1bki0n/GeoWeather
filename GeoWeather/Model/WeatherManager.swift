//
//  WeatherManager.swift
//  GeoWeather
//
//  Created by Makwan BK on 3/17/20.
//  Copyright © 2020 Makwan BK. All rights reserved.
//

import Foundation
import UIKit

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/find?appid=b47e42e749179c4c0db79bf945d92daa&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        
        performRequest(with: urlString)
    }
    
    func fetchCurrentLocation(lat: Double, lon: Double) {
        let urlString = "\(weatherURL)&lat=\(lat)&lon=\(lon)"
        
        performRequest(with: urlString)
    }
     
    var delegate : WeatherManagerDelegate?
    
    func performRequest(with urlString: String) {
        
        guard let url = URL(string: urlString) else {print("Invaild URL"); return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if error != nil {
                self.delegate?.didFailWithError(error: error!)
                return
            }
            
            if let data = data {
                DispatchQueue.main.async {
                    if let weather = self.parseJSON(data) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            
        }.resume()
        
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        
        do {
            let data = try decoder.decode(WeatherData.self, from: weatherData)
            let id = data.list[0].weather[0].id
            let cityName = data.list[0].name
            let temp = data.list[0].main.temp
            
            let weather = WeatherModel(conditionId: id, cityName: cityName, tempurature: temp)
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }

}
