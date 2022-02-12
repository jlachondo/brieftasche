//
//  ErrorMessageView.swift
//  Brieftasche
//
//  Created by Lloyd on 2/12/22.
//

import SwiftUI

struct ErrorMessageView: View {
    var errorCardHeight: CGFloat = 80
    var errorMsg: String = "Something went wrong, please try again."
    var imageName: String = "exclamationmark.circle.fill"
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(UIConfig.errorMsgBgColor)
            .frame(height: errorCardHeight)
            .overlay(
                HStack {
                    Image(systemName: imageName)
                        .foregroundColor(UIConfig.secondaryFontColor)
                        .padding(.horizontal, 5)
                        .font(.system(size: 22))
                    Text(errorMsg)
                        .font(UIConfig.smallFont)
                        .foregroundColor(UIConfig.secondaryFontColor)
                }
                    .padding(10)
//                Added `.frame(maxWidth: .infinity, alignment: .leading)` to adjust the alignment of the hstack content
                    .frame(maxWidth: .infinity, alignment: .leading)
            )
    }
}

struct ErrorMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorMessageView().previewLayout(.sizeThatFits)
    }
}
