import Foundation

class SunTimesService {
    
    var suntimeDelegate: SunTimeDelegate?
    
    func fetchSunTimes() {
        
        guard let delegate = suntimeDelegate else {
            print("Warning - no delegate set")
            return
        }
        
        let url_str = "https://api.sunrise-sunset.org/json?lat=45&lng=-93&date=today"
        let url = URL(string: url_str)
        
        //clearing cache
        let config = URLSessionConfiguration.default
        config.urlCache = nil
        config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in
            
            if let error = error {
                delegate.suntimesError(because: SunTimesError(message: error.localizedDescription))
            }
            
            if let sunTimesData = data {
                let decoder = JSONDecoder()
                let results = try! decoder.decode(Results.self, from: sunTimesData)
                print(results)
            }
        }
        task.resume()
    }
}

class SunTimesError: Error {
    let message: String
    init(message:String) {
        self.message = message
    }
}
