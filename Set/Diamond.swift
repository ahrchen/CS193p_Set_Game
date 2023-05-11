//
//  Diamond.swift
//  Set
//
//  Created by Raymond Chen on 5/10/23.
//

import SwiftUI

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        
        let length = rect.width * 0.3
        let height = length / 2
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let top: CGPoint = CGPoint(x: center.x, y: center.y + height)
        let left: CGPoint = CGPoint(x: center.x - length, y: center.y)
        let bottom: CGPoint = CGPoint(x: center.x, y: center.y - height)
        let right: CGPoint = CGPoint(x: center.x + length, y: center.y)
        var p = Path()
        p.move(to: top)
        p.addLine(to: left)
        p.addLine(to: bottom)
        p.addLine(to: right)
        p.addLine(to: top)
        return p
    }
}
