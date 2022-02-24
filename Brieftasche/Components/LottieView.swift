//
//  LottieView.swift
//  Brieftasche
//
//  Created by Lloyd on 2/24/22.
//

import Lottie
import SwiftUI

struct LottieView: UIViewRepresentable {
    let animationView = AnimationView()
    var lottieFile: String = "coming-soon"
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView()
        let animation = Animation.named(lottieFile)
        
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        return view
    }
    
    // Required by UIViewRepresentable to conform in the protocol
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
        // Do nothing
    }
}

struct LottieView_Previews: PreviewProvider {
    static var previews: some View {
        LottieView()
    }
}
