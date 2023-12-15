import Foundation

struct ItemListData: Equatable {
    // 이 구조체에서 time이 필요한 이유..?
    let cityName: String
    let location: String
    let time: String
    let weather: String
    let temperature: Int
    let maxtemp: Int
    let mintemp: Int
    
    init(cityName: String, location: String, time: Int, weather: String, temperature: Double, maxtemp: Double, mintemp: Double) {
        self.cityName = cityName
        self.time = convertTime(timezone: time)
        self.location = location
        self.maxtemp = convertTemperature(temperature: maxtemp)
        self.mintemp = convertTemperature(temperature: mintemp)
        self.weather = weather
        self.temperature = convertTemperature(temperature: temperature)
    }
}
func convertTime(timezone: Int) -> String {
    let timeZone = TimeZone(secondsFromGMT: timezone)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    dateFormatter.timeZone = timeZone
    let currentDate = Date()
    let formattedTime = dateFormatter.string(from: currentDate)
    return formattedTime
}
func convertTemperature(temperature: Double) -> Int {
    return Int(round((temperature - 273.15)))
}

var itemListData: [ItemListData] = []
