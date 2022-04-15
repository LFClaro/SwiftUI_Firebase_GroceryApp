//
//  LaunchView.swift
//  LuizClaro_N01459385_A2
//
//  Created by Luiz Claro on 2022-04-15.
//

import SwiftUI

let sf = ScaleFactor()

struct LaunchView: View {
    var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var counter: Int = 0
    @State private var loops: Int = 0
    @State private var textSizeChanged = false
    @Binding var showLaunch: Bool
    
    var body: some View {
        ZStack{
            Color("bg").ignoresSafeArea()
            Text("Luiz's Grocr").font(.custom("Avenir-Light", size: sf.h * 0.07))
        }.onReceive(timer , perform: { _ in
            textSizeChanged.toggle()
            withAnimation(.none){
                let lastIndex = 10
                if counter == lastIndex{
                    counter = 0
                    loops += 1
                    if loops >= 2 {
                        showLaunch = false
                    }
                }else{
                    counter += 1
                }
            }
        })
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(showLaunch: .constant(true)).foregroundColor(.white)
    }
}

