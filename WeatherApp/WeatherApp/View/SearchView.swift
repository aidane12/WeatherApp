//
//  ContentView.swift
//  WeatherApp
//
//  Created by Aidan Egan on 2023-03-29.
//
//testing

import SwiftUI
import CoreData

struct SearchView: View {
    
    @ObservedObject var viewModel = SearchViewModel()
    @State var cityName: String = ""
    @State var pushActive = false
    
    var body: some View {
        NavigationView{
            VStack{
                    Text("Search")
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .padding(.vertical, 10)
                        .frame(width: 200)
                        .background(Color.green)
                        .clipShape(Capsule())
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Search")
            .searchable(text: $viewModel.searchTerm, placement: .navigationBarDrawer(displayMode: .always)) {
                ForEach(viewModel.searchResults, id: \.self) { city in
                    NavigationLink(destination: LazyView(view: {
                        WeatherDetailsView(viewModel: WeatherDetailsViewModel(cityName: city))
                    }), isActive: self.$pushActive) {
                        Text(city).searchCompletion(city).onTapGesture {
                            print("this was tapped \(city)")
                            self.pushActive = true
                        }
                    }
                    //pushing view on tap of search result:
               // https://stackoverflow.com/questions/57315409/push-view-programmatically-in-callback-swiftui
                }
            }
        }
    }


struct Search: ViewModifier {
    func body(content: Content) -> some View {
        content
            
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
