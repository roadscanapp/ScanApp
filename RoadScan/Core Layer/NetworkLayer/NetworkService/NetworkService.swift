import Alamofire

struct DangerZoneModel {
    var city: String
    var latitude: Double?
    var longitude: Double?
    var danger_level: Double?
}

protocol NetworkServiceProtocol {
    func postDangerZone(param: DangerZoneModel, comp: @escaping((DangerZoneModel)-> ()))
}

final class NetworkService: NetworkServiceProtocol {
    
    func postDangerZone(param: DangerZoneModel, comp: @escaping ((DangerZoneModel) -> ())) {
        guard let lat = param.latitude,
              let lon = param.longitude,
              let dangerLvl = param.danger_level else {
            return
        }
        
        let param = [
            "city": param.city,
            "latitude": lat,
            "longitude": lon,
            "danger_level": dangerLvl
        ] as [String : Any]
        
        AF.request(NetworkConstants.baseURL, method: .post, parameters: param, encoding: URLEncoding.default).response { response in
            switch response.result {
            case .success(let data):
                debugPrint(data)
            case .failure(let error):
               debugPrint(error)
            }
        }
    }
}




