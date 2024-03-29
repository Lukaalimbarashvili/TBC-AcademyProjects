//
//  Canvas.swift
//  Homework 38
//
//  Created by Luka Alimbarashvili on 6/10/20.
//  Copyright © 2020 lucas. All rights reserved.
//

import Foundation
import UIKit

class Canvas: UIView {
    
    var strokeColor: UIColor = UIColor.black
    var strokeWidth: Float = 1
    
    func setStrokeWidth(width: Float) {
        self.strokeWidth = width
    }
    
    func setColor(color: UIColor) {
        self.strokeColor = color
    }
    
    func undo() {
        _ = lines.popLast()
        setNeedsDisplay()
    }
    func clear() {
        lines.removeAll()
        setNeedsDisplay()
    }
    
    var lines = [Line]()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        
        
        
        lines.forEach { (line) in
            context.setStrokeColor(line.color.cgColor)
            context.setLineWidth(CGFloat(line.strokeWidth))
            
            for (i, p) in line.points.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }

            }
              context.strokePath()
        }
        
        
      
    }
       
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(Line.init(strokeWidth: strokeWidth, color: strokeColor, points: []))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else {return}
        
        guard var lastLine = lines.popLast() else { return }
        lastLine.points.append(point)
        
        lines.append(lastLine)
        
        setNeedsDisplay()
    }
}
