//
//  Cardify.swift
//  Set
//
//  Created by Raymond Chen on 5/10/23.
//

import SwiftUI

struct Cardify: ViewModifier {
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            shape.fill(.white)
            shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
            content.opacity(1)
        }
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
}

extension View {
    func cardify() -> some View {
        return self.modifier(Cardify())
    }
}

struct Cardify_Previews: PreviewProvider {
    static var previews: some View {
        Text("🗿")
            .modifier(Cardify())
    }
}
