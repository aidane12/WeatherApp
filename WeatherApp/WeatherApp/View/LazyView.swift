//
//  LazyView.swift
//  WeatherApp
//
//  Created by Aidan Egan on 2023-04-03.
//

import Foundation
import SwiftUI

//created to deal with problem for WeatherDetailsViewModel getting initilizaed everytime I typed a letter in search

struct LazyView <T: View> : View {
    var view: () -> T
    var body: some View {
        self.view()
    }
}
