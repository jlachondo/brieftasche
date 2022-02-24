//
//  LogoView.swift
//  Brieftasche
//
//  Created by Lloyd on 2/12/22.
//

import SwiftUI

struct LogoView: View {
    var alignment: Alignment = .center
    var font: Font = UIConfig.regularFont
    var height: CGFloat = 150
    var imageName: String = "logo"
    var imageLbl: String?
    var width: CGFloat = 150
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .frame(width: width, height: height, alignment: alignment)
            if imageLbl != nil {
                Text(imageLbl!)
                    .font(font)
                    .foregroundColor(UIConfig.primaryFontColor)
            }
        }
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView().previewLayout(.sizeThatFits)
    }
}
