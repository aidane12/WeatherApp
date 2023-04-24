//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Aidan Egan on 2023-03-29.
//

import SwiftUI

@main
struct ContentView: App {
    @StateObject private var dataController = DataContoller()
    @ObservedObject var networkManger = NetworkManager()
    @State var isShowingSearchView = true

    var body: some Scene {
        WindowGroup {
            Group {
                if isShowingSearchView {
                    SearchView()
                        .environment(\.managedObjectContext, dataController.container.viewContext)
                }
                else {
                    SearchHistoryView()
                        .environment(\.managedObjectContext, dataController.container.viewContext)
                }
            }.alert("The Internet connection is currently offline", isPresented: $networkManger.isDisconnected) { }
        }
    }
}


