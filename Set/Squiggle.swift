//
//  Squiggle.swift
//  Set
//
//  Created by Raymond Chen on 5/10/23.
//

import SwiftUI

struct Squiggle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let length = rect.width * 0.4
        let height = length / 2
        path.move(to: CGPoint(x: rect.midX - length, y: rect.midY + height / 2))
        path.addCurve(to: CGPoint(x: rect.midX + length, y: rect.midY + height / 2),
                      control1: CGPoint(x: rect.midX - length/2, y: rect.midY - height),
                      control2: CGPoint(x: rect.midX + length/2, y: rect.midY + height))
        path.addLine(to: CGPoint(x: rect.midX + length, y: rect.midY - height / 2))
        
        path.addCurve(to: CGPoint(x: rect.midX - length, y: rect.midY - height / 2),
                      control1: CGPoint(x: rect.midX + length/2, y: rect.midY + height),
                      control2: CGPoint(x: rect.midX - length/2, y: rect.midY - height))
        path.addLine(to: CGPoint(x: rect.midX - length, y: rect.midY + height / 2))
        
        return path
    }
}
