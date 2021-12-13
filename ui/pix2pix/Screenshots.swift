//
//  Screenshots.swift
//  pix2pix
//
//  Created by Rita Konnova on 14.12.2021.
//

import AppKit
import Cocoa
import Foundation

func takeScreenshots(folderName: String){
   
   var displayCount: UInt32 = 0;
   var result = CGGetActiveDisplayList(0, nil, &displayCount)
   if (result != CGError.success) {
       print("error: \(result)")
       return
   }
   let allocated = Int(displayCount)
   let activeDisplays = UnsafeMutablePointer<CGDirectDisplayID>.allocate(capacity: allocated)
   result = CGGetActiveDisplayList(displayCount, activeDisplays, &displayCount)
   
   if (result != CGError.success) {
       print("error: \(result)")
       return
   }
      
   for i in 1...displayCount {
       let unixTimestamp = timeStamp()
       let fileUrl = URL(fileURLWithPath: folderName + "sketch.jpg", isDirectory: true)
       let screenShot: CGImage = CGDisplayCreateImage(activeDisplays[Int(i-1)])!
       let bitmapRep = NSBitmapImageRep(cgImage: screenShot)
       let jpegData = bitmapRep.representation(using: NSBitmapImageRep.FileType.jpeg, properties: [:])!
       
       do {
           try jpegData.write(to: fileUrl, options: .atomic)
       }
       catch {print("error: \(error)")}
   }
}

func timeStamp() -> Int32
{
   return Int32(Date().timeIntervalSince1970)
}
