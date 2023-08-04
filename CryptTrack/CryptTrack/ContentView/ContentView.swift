//
//  ContentView.swift
//  CryptTrack
//
//  Created by Zafa on 
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = ViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Stepper("Amount: $\(Int(vm.amount))", value: $vm.amount, step: 100)
                        .padding()
                    Slider(value: $vm.amount, in: 1...10_000)
                        .padding([.horizontal, .bottom])
                }
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding()

                List(vm.filteredRates) { item in
                    HStack {
                        Text(item.asset_id_quote)
                            .font(.headline)
                            .foregroundColor(.primary)
                        Spacer()
                        Text("\(vm.calcRate(rate: item), specifier: "%.2f")")
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 8)
                }
                .listStyle(.plain)
                .searchable(text: $vm.searchText)
                .onAppear(perform: vm.refreshData)
            }
            .navigationTitle("CrypTracker")
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        withAnimation {
                            vm.refreshData()
                        }
                    }) {
                        Image(systemName: "arrow.clockwise")
                            .font(.title)
                            .foregroundColor(.primary)
                    }
                }
            }
        }
        .accentColor(.purple) // Setting the accent color for the whole view
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
