//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Jacek Placek on 06/08/2022.
//

import SwiftUI



struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct ContentView: View {
    @StateObject var order = Order()

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(Order.types.indices) {
                            Text(Order.types[$0])
                        }
                    }

                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 3...20)
                }
                Section {
                    Toggle("Any special requests?", isOn: $order.specialRequestEnabled.animation())

                    if order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)

                        Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
                    }
                }
                Section {
                    NavigationLink{
                    AddressView(order: order)
                    } label: {
                        Text("Delivery Adress")
                    }
                    
                }
            }
            .navigationTitle("Cupcake Corner")
        }
   }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
