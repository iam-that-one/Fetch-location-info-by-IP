//
//  LocationViewModel.swift
//  Find-location-by-IP
//
//  Created by Abdullah Alnutayfi on 13/04/2021.
//

import Foundation
class LocationViewModel: ObservableObject{
    @Published var locations = [Location]()
    func fetch_location(ip : String){
        let API_KEY = ""
        let API_URL = "https://api.ipgeolocation.io/ipgeo?apiKey=\(API_KEY)&ip=\(ip)"
        guard let url = URL(string: API_URL)else{
            print("invalid url ...")
            return
        }
        let decoder = JSONDecoder()
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil{
                print("error 1")
                print(error?.localizedDescription as Any)
            }
            else{
                if let data = data{
                    do{
                    let result = try decoder.decode(Location.self, from: data)
                        print(result)
                        DispatchQueue.main.async {
                            self.locations.append(result)
                        }
                        
                    }catch{
                        print("errpr 2")
                        print(error)
                    }
                }
            }
        }.resume()
    }
    func loadImage(ImageUrl: String) -> Data?{
       
        guard let url = URL(string: ImageUrl) else {return Data()}
        if let data = try? Data(contentsOf: url){
            return data
        }
        return nil
    }
}




// MARK: - Location
struct Location: Codable, Identifiable{
    let ip, hostname, continentCode, continentName: String?
    var id : String{
        ip!
    }
    let countryCode2, countryCode3, countryName, countryCapital: String?
    let stateProv, district, city, zipcode: String?
    let latitude, longitude: String?
    let isEu: Bool?
    let callingCode, countryTLD, languages: String?
    let countryFlag: String?
    let geonameID, isp, connectionType, organization: String?
    let asn: String?
    let currency: Currency?
    let timeZone: TimeZone?

    enum CodingKeys: String, CodingKey {
        case ip, hostname
        case continentCode = "continent_code"
        case continentName = "continent_name"
        case countryCode2 = "country_code2"
        case countryCode3 = "country_code3"
        case countryName = "country_name"
        case countryCapital = "country_capital"
        case stateProv = "state_prov"
        case district, city, zipcode, latitude, longitude
        case isEu = "is_eu"
        case callingCode = "calling_code"
        case countryTLD = "country_tld"
        case languages
        case countryFlag = "country_flag"
        case geonameID = "geoname_id"
        case isp
        case connectionType = "connection_type"
        case organization, asn, currency
        case timeZone = "time_zone"
    }
}

// MARK: - Currency
struct Currency: Codable {
    let code, name, symbol: String?
}

// MARK: - TimeZone
struct TimeZone: Codable {
    let name: String?
    let offset: Int?
    let currentTime: String?
    let currentTimeUnix: Double?
    let isDst: Bool?
    let dstSavings: Int?

    enum CodingKeys: String, CodingKey {
        case name, offset
        case currentTime = "current_time"
        case currentTimeUnix = "current_time_unix"
        case isDst = "is_dst"
        case dstSavings = "dst_savings"
    }
}
