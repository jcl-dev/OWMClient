import Foundation
import SwiftyJSON

/// A Swift client to access the api at `api.openweathermap.org`
public struct OWMClient {
    
    private let apiKey: String
    
    /// Creates and returns a new instance
    /// - Parameter apiKey: Your api key for openweathermap
    public init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    /// Returns the temperature, in fahrenheit, for the given city
    /// - Parameter city: The name of the city to check the temp of. Example: "Boise" or "Fort Wayne"
    /// - Throws: ClientError
    /// - Returns: The temperature, in fahrenheit, of the given city
    public func getTemp(city: String) throws -> Double {
        var temp: Double = 0
        var error: ClientError? = nil
        let semaphore = DispatchSemaphore(value: 0)
        getTemp(city: city) { result in
            switch result {
            case .success(let t):
                temp = t
            case .failure(let err):
                error = err
            }
            semaphore.signal()
        }
        _ = semaphore.wait(timeout: .distantFuture)
        if let error = error {
            throw error
        }
        return temp
    }
    
    /// Returns the temperature, in fahrenheit, for the given city asynchronously in the completion callback
    /// - Parameters:
    ///   - city: The name of the city to check the temp of. Example: "Boise" or "Fort Wayne"
    ///   - completion: A closure which will receive the result of the operation when it is complete.
    public func getTemp(city: String, completion: @escaping (Result<Double,ClientError>) -> Void) {
        let urlEncodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?units=imperial&q=\(urlEncodedCity)&appid=\(apiKey)")!
        let task = URLSession.shared.dataTask(with: url) { data, res, err in
            if let err = err {
                return completion(.failure(.dataTask(err)))
            }
            guard
                let data = data
                else { return completion(.failure(.nilData)) }
            guard
                let json = try? JSON(data: data),
                let temp = json["main"]["temp"].double
                else { return completion(.failure(.mainTempNotFound)) }
//            // Non-SwiftyJSON
//            let jsonObj: Any
//            do {
//                jsonObj = try JSONSerialization.jsonObject(with: data, options: [])
//            } catch(let err) {
//                return completion(.failure(.jsonDecode(err)))
//            }
//            guard
//                let root = jsonObj as? [String: Any],
//                let main = root["main"] as? [String: Any],
//                let temp = main["temp"] as? Double else {
//                    return completion(.failure(.mainTempNotFound))
//            }
            return completion(.success(temp))
        }
        task.resume()
    }
    
    /// The error type used in the OpenWeatherMap client
    public enum ClientError: Error {
        case dataTask(Error)
        case nilData
        case jsonDecode(Error)
        case mainTempNotFound
    }
}
