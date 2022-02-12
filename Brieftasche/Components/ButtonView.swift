//
//  ButtonView.swift
//  Brieftasche
//
//  Created by Lloyd on 2/12/22.
//

import LoadingButton
import SwiftUI

struct ButtonView: View {
    
    @Binding var isLoading: Bool
    
    var action: () -> Void
    var background: Color = UIConfig.primaryBtnBGColor
    var cornerRadius: CGFloat = 10
    var foregroundColor: Color = UIConfig.secondaryFontColor
    var height: CGFloat = 50
    var text: String = "Button"
    var width: CGFloat = 200
    
    var body: some View {
        let style = LoadingButtonStyle(
            width: width,
            height: height,
            cornerRadius: cornerRadius,
            backgroundColor: background,
            loadingColor: UIConfig.secondaryBtnBGColor,
            strokeWidth: 5,
            strokeColor: background)
        
        LoadingButton(action: {
            action()
        }, isLoading: $isLoading, style: style) {
            Text(text)
//                .frame(width: width, height: height)
//                .background(background)
//                .cornerRadius(cornerRadius)
                .foregroundColor(foregroundColor)
                .font(UIConfig.regularFont)
        }
        .disabled(isLoading)
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(isLoading: .constant(false), action: {}).previewLayout(.sizeThatFits)
    }
}
