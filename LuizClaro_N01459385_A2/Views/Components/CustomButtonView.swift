//
//  CustomButtonView.swift
//  LuizClaro_N01459385_A2
//
//  Created by Luiz Claro on 2022-04-15.
//

import SwiftUI

struct CustomButtonView: View {
    var text : String?
    var color : Color?
    var action : (() -> Void)?
    
    var body: some View {
        Button(action: self.action ?? {}) {
            ZStack{
                color ?? Color("AccentColor")
                Text(text ?? "Login")
                    .font(.custom("Avenir-Light", size: sf.h * 0.035))
                    .foregroundColor(.white)
            }
            .frame(maxHeight: sf.h * 0.04)
            .cornerRadius(5)
        }
    }
}

struct CustomButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CustomButtonView(color: Color("bg"))
    }
}
