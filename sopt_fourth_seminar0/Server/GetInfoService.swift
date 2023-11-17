//
//  GetInfoService.swift
//  sopt_fourth_seminar0
//
//  Created by Woo Jye Lee on 11/15/23.
//

// 홈화면 tableviewcell의 날씨정보를 가져옵니다.
import Foundation

class GetInfoService {
    static let shared = GetInfoService()
    private init() {}
    let APIkey: String = "c2cad16c620c4af5508892bc7357e0fc"
    
    func makeRequest(cityname: String) -> URLRequest {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityname)&appid=\(APIkey)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let header = ["Content-Type": "application/json"]
        header.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        return request
    }
    
    // 조회만 하면 되서 POST는 사용하지 않아도됨(?) -> 아래 코드까지 해줘야 서버의 데이터를 얻어올 수 있는듯.
    func PostRegisterData(cityname: String) async throws -> UserInfoDataModel? {
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
    
    // server로부터 가져윤 JSON을 구조체로 바꾸는 과정
    private func parseUserInfoData(data: Data) -> UserInfoDataModel? {
        do {
            let jsonDecoder = JSONDecoder()
            let result = try jsonDecoder.decode(UserInfoDataModel.self, from: data)
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
