//
//  LoadingView.swift
//  LuizClaro_N01459385_A2
//
//  Created by Luiz Claro on 2022-04-15.
//

import SwiftUI
import SwiftfulLoadingIndicators

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color("bg").ignoresSafeArea().opacity(0.8)
            VStack{
                LoadingIndicator(animation: .circleTrim, color: Color("AccentColor"), size: .extraLarge)
                Text("Loading...")
                    .font(.custom("Avenir-Light", size: sf.h * 0.05))
                    .foregroundColor(.white)
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
