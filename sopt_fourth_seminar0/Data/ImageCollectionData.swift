
// 시간대별 날씨 정보 데이터모델
import Foundation

struct ImageCollectionData {
    let time: String
    let weather: String // weather icon
    let temperature: Int
    
    init(time: String, weather: String, temperature: Double) {
        self.time = extractHour(from: time)!
        self.weather = weather
        self.temperature = convertTemperature2(temperature: temperature)
    }
}
// invalid redeclarion of function error
func convertTemperature2(temperature: Double) -> Int {
    return Int(round((temperature - 273.15)))
}

func extractHour(from dateString: String) -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    if let date = dateFormatter.date(from: dateString) {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        return String(format: "%02d시", hour)
    }
    
    return nil
}

var imageCollectionList: [ImageCollectionData] = []
