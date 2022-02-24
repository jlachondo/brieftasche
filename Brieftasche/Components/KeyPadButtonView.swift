//
//  KeyPadButtonView.swift
//  Brieftasche
//
//  Created by Lloyd on 2/21/22.
//

import SwiftUI

struct KeyPadButtonView: View {
    var key: String
    
    var body: some View {
        Button(action: { self.action(self.key) }) {
            Color.clear
            //                .overlay(RoundedRectangle(cornerRadius: 12)
            //                            .stroke(Color.accentColor))
                .overlay(
                    Text(key)
                        .foregroundColor(UIConfig.primaryFontColor)
                        .font(UIConfig.xLargeFont)
                )
        }
    }
    
    // Create an environment key
    enum ActionKey: EnvironmentKey {
        static var defaultValue: (String) -> Void { { _ in } }
    }
    
    // Let `keyPadButtonAction` be accessible globally
    @Environment(\.keyPadButtonAction) var action: (String) -> Void
}

// Extend the environment - to provide a getter/setter that we can use
extension EnvironmentValues {
    var keyPadButtonAction: (String) -> Void {
        get { self[KeyPadButtonView.ActionKey.self] }
        set { self[KeyPadButtonView.ActionKey.self] = newValue }
    }
}

struct KeyPadButtonView_Previews: PreviewProvider {
    static var previews: some View {
        KeyPadButtonView(key: "9")
            .padding()
            .frame(width: 80, height: 80)
            .previewLayout(.sizeThatFits)
    }
}
