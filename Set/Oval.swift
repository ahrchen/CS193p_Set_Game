//
//  Oval.swift
//  Set
//
//  Created by Raymond Chen on 5/10/23.
//

import SwiftUI

struct Oval: Shape {
    var cornerRadius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width * 0.7
        let height = width / 3
        let x = rect.midX - (width / 2)
        let y = rect.midY - (height / 2)

        path.move(to: CGPoint(x: x + cornerRadius, y: y))
        path.addLine(to: CGPoint(x: x + width - cornerRadius, y: y))
        path.addCurve(to: CGPoint(x: x + width, y: y + cornerRadius),
                      control1: CGPoint(x: x + width - cornerRadius / 2, y: y),
                      control2: CGPoint(x: x + width, y: y + cornerRadius / 2))
        path.addLine(to: CGPoint(x: x + width, y: y + height - cornerRadius))
        path.addCurve(to: CGPoint(x: x + width - cornerRadius, y: y + height),
                      control1: CGPoint(x: x + width, y: y + height - cornerRadius / 2),
                      control2: CGPoint(x: x + width - cornerRadius / 2, y: y + height))
        path.addLine(to: CGPoint(x: x + cornerRadius, y: y + height))
        path.addCurve(to: CGPoint(x: x, y: y + height - cornerRadius),
                      control1: CGPoint(x: x + cornerRadius / 2, y: y + height),
                      control2: CGPoint(x: x, y: y + height - cornerRadius / 2))
        path.addLine(to:CGPoint(x:x,y:y+cornerRadius))
        path.addCurve(to:CGPoint(x:x+cornerRadius,y:y),control1:CGPoint(x:x,y:y+cornerRadius/2),control2:CGPoint(x:x+cornerRadius/2,y:y))

        return path
    }
}
