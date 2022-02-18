//
//  ClassicListView.swift
//  Brieftasche
//
//  Created by Lloyd on 2/19/22.
//

import SwiftUI

struct ClassicListView: View {
    
    var imageName: String = "envelope.fill"
    var isLoading: Bool = false
    var isPressable: Bool = true
    var text: String = "List name"
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .foregroundColor(Color(.systemGray3))
                .frame(width: 30, alignment: .leading)
            Text(text)
                .foregroundColor(UIConfig.primaryFontColor)
                .font(UIConfig.smallFont)
            Spacer()
            if isPressable {
                Image(systemName: "chevron.right")
                    .foregroundColor(Color(.systemGray3))
                    .font(.system(size: 20))
            } else if !isPressable && isLoading {
                ProgressView()
            }
        }
        .padding(EdgeInsets(top: 20, leading: 21, bottom: 20, trailing: 21))
    }
}

struct ClassicListView_Previews: PreviewProvider {
    static var previews: some View {
        ClassicListView()
            .previewLayout(.sizeThatFits)
    }
}
