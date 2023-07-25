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
    // No need to create this var. Can just reference vm F temp.
    var body: some View {
        
        ZStack{
            if viewModel.isLoading || viewModel.weather == nil {
                Color.black.opacity(0.2)
                    .edgesIgnoringSafeArea(.all)
                    .transition(.opacity)
                
                ProgressView()
                    .scaleEffect(2.0)
                    .progressViewStyle(CircularProgressViewStyle())
            } else if let weather = viewModel.weather {
                
            VStack(){
                    HStack{
                        // Use string interpolation
                        Text("\((weather.city.name)),")
                        Text(weather.city.country)
                    }
                    .font(.system(size: 29, weight: .semibold))
                    .padding(.bottom, 50)
                    
                    
                    
                    HStack{
                        // AsyncImage handles the image loading for us automatically.
                        AsyncImage(url: weather.imageURL)
                            .scaledToFit()
                            .frame(width: 85)
                            .clipShape(Circle())
                            .shadow(radius: 10)
                            .padding(.horizontal)
                            .padding(.top)
                        
                        Spacer()
                        
                        VStack(spacing: 4) {
                            Text("\(weather.tempCelcius) °C /")
                            Text("\(weather.tempFahrenheit)°F ")
                        }
                        
                    }
                    .padding([.leading, .trailing], 60)
                    .font(.system(size: 20, weight: .semibold))
                    .padding(.bottom, 60)
                    
                    VStack(spacing: 15){
                        Text("\(weather.city.formattedTime)")
                            .font(.system(size: 29, weight: .semibold))
                        
                        Text("\(weather.city.formattedDate)")
                            .font(.system(size: 29, weight: .regular))
                    }
                    .padding(.bottom, 50)
                    
                // The image retrieval can be improved. This is where my SwiftUI unfamiliarity prevents me from giving the best answer
                ShareLink(item: weather, subject: Text("Weather details"), preview: SharePreview("Share the weather with a friend!",  image: weather.image)) {
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
    }
}


struct WeatherDetailsView_Previews: PreviewProvider {
    
    static var previews: some View {
        WeatherDetailsView(viewModel: WeatherDetailsViewModel(cityName: "London"))
    }
}
