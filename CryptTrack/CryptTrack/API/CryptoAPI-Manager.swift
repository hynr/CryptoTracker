//
//  CryptoAPI-Manager.swift
//  CryptTrack
//
//  Created by Zafa 
//

import Foundation

class CryptoAPI {
    let API_KEY = "02E75D80-6A0A-4459-9EF9-8AA89EE58006"
    
    func getCryptoData(currency: String, previewMode: Bool, _ completion:@escaping([Rate]) ->()) {
        if previewMode {
            completion(Rate.sampleRates)
            return
        }
        
        let urlString = "https://rest.coinapi.io/v1/exchangerate/\(currency)?invert=false&apikey=\(API_KEY)"
        
        guard let url = URL(string: urlString) else {
            print("CryptoAPI: Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print("CryptoAPI: Could not retrieve data")
                return
            }
            do {
                let ratesData = try JSONDecoder().decode(Crypto.self, from: data)
                completion(ratesData.rates)
            } catch {
                print("CryptoAPI: \(error)")
                completion(Rate.sampleRates)
            }
        }
        .resume()
    }
}
