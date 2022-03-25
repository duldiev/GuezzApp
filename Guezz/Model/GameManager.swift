//
//  GameManager.swift
//  Guezz
//
//  Created by Raiymbek Duldiev on 28.02.2022.
//

import Foundation

//protocol WeatherManagerDelegate {
//    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
//    func didFailWithError(error: Error)
//}

protocol GameManagerDelegate {
    func didUpdateGame(_ gameManager: GameManager, track: TrackModel)
    func didFailWithError(error: Error)
}

struct GameManager {
    
    var delegate: GameManagerDelegate?
    
    func performRequest() {
        let url = URL(string: "https://api.spotify.com/v1/tracks/2TpxZ7JUBn3uw46aR7qd6V")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.addValue("Bearer BQDIfwW_1efbkhsMnor1vAYOoiUL_yYzaxGIe3wKPParWO3I65lZ5SW_jdXl4l6T-DvcSwPMS-XqTIJh69M", forHTTPHeaderField: "Authorization")
        request.addValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        let dataTask = URLSession.shared.dataTask(with: url!) { data,response,error in
            // 1: Check HTTP Response for successful GET request
            guard let httpResponse = response as? HTTPURLResponse, let receivedData = data
            else {
                print("error: not a valid http response")
                return
            }
            switch (httpResponse.statusCode) {
            case 200:
                print("YES")
                break
            case 400:
                break
            default:
                break
            }
            
            print(httpResponse)
            print(receivedData)
            
            if let trackData = self.parseJSON(receivedData) {
                print("YES")
                self.delegate?.didUpdateGame(self, track: trackData)
            }
        }
        dataTask.resume()
    }
    
    func parseJSON(_ trackData: Data) -> TrackModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(TrackModel.self, from: trackData)
            let id = decodedData.id

            let track = TrackModel(id: id)
            return track
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
