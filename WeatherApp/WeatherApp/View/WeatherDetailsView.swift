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
        VStack(){
            HStack{
                Text(viewModel.weather.city.name + ",")
                Text(viewModel.weather.city.country)
            }
            .font(.system(size: 29, weight: .semibold))
            .padding(.bottom, 50)
          
            
            HStack{
                viewModel.weather.image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 85)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .padding(.horizontal)
                    .padding(.top)
                
                    
                
                Spacer()
                
                VStack(spacing: 4) {
                    Text("\(viewModel.weather.tempCelcuis) °C /")
                    Text("\(ferinheight)°F ")
                        .onAppear {
                            ferinheight = viewModel.calculateFahrenheit(celsius: viewModel.weather.tempCelcuis)
                        }
                }
                
            }
            .padding([.leading, .trailing], 60)
            .font(.system(size: 20, weight: .semibold))
            .padding(.bottom, 60)
            
            VStack(spacing: 15){
                Text("\(viewModel.weather.city.formattedTime ?? "unable to find time")")
                    .font(.system(size: 29, weight: .semibold))
                
                Text("\(viewModel.weather.city.formattedDate ?? "unable to find date")")
                    .font(.system(size: 29, weight: .regular))
            }
            .padding(.bottom, 50)
            
            ShareLink(item: viewModel.weather, subject: Text("Weather details"), preview: SharePreview("Share the weather with a friend!",  image: viewModel.weather.image)) {
                Text("Share with a friend")
                    .foregroundColor(.white)
                    .padding(10)
                    .background(.gray)
                    .cornerRadius(5)
                    .shadow(color: .gray, radius: 4)
            }
            .padding(.bottom, 200)
        }
    }
}


struct WeatherDetailsView_Previews: PreviewProvider {
    
    static var previews: some View {
        WeatherDetailsView(viewModel: WeatherDetailsViewModel(cityName: "London"))
    }
}
