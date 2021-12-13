//
//  DrawView.swift
//  pix2pix
//
//  Created by Rita Konnova on 13.12.2021.
//

import Cocoa

class DrawView: NSView {
  var path: NSBezierPath = NSBezierPath()

  override func mouseDown(with event: NSEvent) {
    path.move(to: convert(event.locationInWindow, from: nil))
    needsDisplay = true
  }

  override func mouseDragged(with event: NSEvent) {
    path.line(to: convert(event.locationInWindow, from: nil))
    needsDisplay = true
  }

  override func draw(_ dirtyRect: NSRect) {
    super.draw(dirtyRect)
    
//    self.boxType = .custom
//    self.alphaValue = 1
//    self.borderColor = NSColor(calibratedRed: 0, green: 0.746, blue: 0.996, alpha: 1)
//    self.borderWidth = 4

    NSColor.black.set()

    path.lineJoinStyle = .round
    path.lineCapStyle = .round
    path.lineWidth = 2.0
    path.stroke()
  }
  
  public func clear() {
    path.removeAllPoints()
    self.setNeedsDisplay(self.frame)
  }
}
