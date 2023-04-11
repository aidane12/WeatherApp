//
//  WeatherDetailsView.swift
//  WeatherApp
//
//  Created by Aidan Egan on 2023-04-04.
//

import Foundation
import SwiftUI

struct WeatherDetailsView: View {
    
    @ObservedObject var viewModel : WeatherDetailsViewModel
    @State var ferinheight : Int = 0
    
   
    
    var body: some View {
        VStack {
            Text("City: \(viewModel.weather.city.name)")
            Text("Country: \(viewModel.weather.city.country)")
            Text("This is the temp \(viewModel.weather.tempCelcuis) degrees")
            Text("The time is \(viewModel.weather.city.time)")
            Text("This is the image url: \(viewModel.weather.imageURL)")
            Text("This is the temp \(ferinheight) Fahrenheit")
                .onAppear {
                    ferinheight = viewModel.calculateFahrenheit(celsius: viewModel.weather.tempCelcuis)
                }
                viewModel.weather.image
                    .frame(width: 32.0, height: 32.0)
                    
            ShareLink(item: viewModel.weather, subject: Text("Aidans email Subject line"), preview: SharePreview("Share the weather with a friend!",  image: viewModel.weather.image))
        }
        
        
        //add search functionality using this example:
    //https://www.google.com/search?q=swift+ui+search+bar+with+results+as+typing&oq=swift+ui+search+bar+with+results+as+typing+&aqs=chrome..69i57j33i10i160l5.11872j0j7&sourceid=chrome&ie=UTF-8#fpstate=ive&vld=cid:fd252661,vid:sTE3IP4Qihg
        
        
    }
}
