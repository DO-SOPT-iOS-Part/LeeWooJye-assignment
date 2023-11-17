//
//  GetTimeline.swift
//  sopt_fourth_seminar0
//
//  Created by Woo Jye Lee on 11/16/23.
//

import Foundation

class GetTimeline {
    static let shared = GetTimeline()
    private init() {}
    let APIkey: String = "c2cad16c620c4af5508892bc7357e0fc"
    
    func makeRequest(cityname: String) -> URLRequest {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=\(cityname)&appid=\(APIkey)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let header = ["Content-Type": "application/json"]
        header.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        return request
    }
    
    func GetTimelineData(cityname: String) async throws -> HourlyInfoDataModel? {
        do {
            let request = self.makeRequest(cityname: cityname)
            let (data, response) = try await URLSession.shared.data(for: request)
            dump(request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.responseError
            }
            dump(response)
            guard let parseData = parseUserInfoData(data: data)
            else {
                throw NetworkError.responseDecodingError
            }
            return parseData
        } catch {
            throw error
        }
        
    }
    
    private func parseUserInfoData(data: Data) -> HourlyInfoDataModel? {
        do {
            let jsonDecoder = JSONDecoder()
            let result = try jsonDecoder.decode(HourlyInfoDataModel.self, from: data)
            return result
        } catch {
            print(error)
            return nil
        }
    }
    
    private func configureHTTPError(errorCode: Int) -> Error {
        return NetworkError(rawValue: errorCode)
        ?? NetworkError.unknownError
    }
    
}
