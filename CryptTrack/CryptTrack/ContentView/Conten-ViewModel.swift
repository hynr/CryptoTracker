//
//  Conten-ViewModel.swift
//  CryptTrack
//
//  Created by Zafa 
//

import Foundation
import SwiftUI


extension ContentView {
    class ViewModel: ObservableObject {
        @Published var rates = [Rate]()
        @Published var searchText = ""
        @Published var amount: Double = 1
        
        var filteredRates: [Rate] {
            return searchText == "" ? rates : rates.filter { $0.asset_id_quote.contains(searchText.uppercased())}
        }
        
        func calcRate(rate: Rate) -> Double {
            return amount * rate.rate
        }
        
        func refreshData() {
            CryptoAPI().getCryptoData(currency: "USD", previewMode: false) { newRates in DispatchQueue.main.async{
                withAnimation {
                    self.rates = newRates
                }
                print("Successfully pulled new rates: \(self.rates.count)")
            }
                
            }
            
        }

    }
}
