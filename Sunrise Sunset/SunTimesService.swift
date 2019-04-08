import Foundation

class SunTimesService {
    
    func fetchSunTimes() {
        
        let url_str = "https://api.sunrise-sunset.org/json?lat=45&lng=-93&date=today"
            //"https://api.sunrise-sunset.org/json?lat=45&1ng=-93"
        let url = URL(string: url_str)
        
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in
            
            if let sunTimesData = data {
                let decoder = JSONDecoder()
                let results = try! decoder.decode(Results.self, from: sunTimesData)
                print(results)
            }
        }
        task.resume()
    }
}
