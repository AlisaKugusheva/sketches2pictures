//
//  ToolButton.swift
//  pix2pix
//
//  Created by Rita Konnova on 13.12.2021.
//

import Cocoa

class ToolButton: NSButton {
  
  var clickHandler: (() -> Void)?
  public var buttonColor: NSColor = NSColor(calibratedRed: 0, green: 0.746, blue: 0.996, alpha: 1)
  public var onClickColor: NSColor = NSColor(calibratedRed: 0.078, green: 0.515, blue: 0.800, alpha: 1)
  public var textColor: NSColor = NSColor(calibratedRed: 1, green: 1, blue: 1, alpha: 1)
  
  override func mouseDown(with event: NSEvent) {
    super.mouseDown(with: event)
    self.clickHandler?()
    needsDisplay = true
  }
  
  public override func draw(_ dirtyRect: NSRect) {
    super.draw(dirtyRect)
    let rectanglePath = NSBezierPath(rect: NSRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
         
    var fillColor: NSColor
    var strokeColor: NSColor
    
    rectanglePath.fill()
    
    if self.isHighlighted {
        strokeColor = self.buttonColor
        fillColor = self.onClickColor
    } else {
        strokeColor = self.onClickColor
        fillColor = self.buttonColor
    }
 
    strokeColor.setStroke()
    rectanglePath.lineWidth = 5
    rectanglePath.stroke()
    fillColor.setFill()
    rectanglePath.fill()
    bezelStyle = .shadowlessSquare
    
    self.layer?.masksToBounds = true
    self.layer?.cornerRadius = self.frame.height / 4
 
    let textRect = NSRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
    let textTextContent = self.title
    let textStyle = NSMutableParagraphStyle()
    textStyle.alignment = .center
    
    let textFontAttributes : [ NSAttributedString.Key : Any ] = [
      .font: NSFont.systemFont(ofSize: NSFont.systemFontSize),
      .foregroundColor: textColor,
      .paragraphStyle: textStyle
    ]

    let textTextHeight: CGFloat = textTextContent.boundingRect(with: NSSize(width: textRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: textFontAttributes).height
    let textTextRect: NSRect = NSRect(x: 0, y: -3 + ((textRect.height - textTextHeight) / 2), width: textRect.width, height: textTextHeight)
    NSGraphicsContext.saveGraphicsState()
    textTextContent.draw(in: textTextRect.offsetBy(dx: 0, dy: 3), withAttributes: textFontAttributes)
    NSGraphicsContext.restoreGraphicsState()
  }

}
