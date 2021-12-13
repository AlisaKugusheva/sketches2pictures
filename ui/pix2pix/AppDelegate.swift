//
//  AppDelegate.swift
//  pix2pix
//
//  Created by Rita Konnova on 13.12.2021.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {

  private var window: NSWindow?


  func applicationDidFinishLaunching(_ aNotification: Notification) {
    window = NSWindow(
      contentRect: NSMakeRect(0, 0, 1100, 500),
      styleMask: [.miniaturizable, .closable, .resizable, .titled],
      backing: .buffered,
      defer: false
    )
    window?.contentViewController = ViewController()
    window?.title = "cars pix2pix"
    window?.makeKeyAndOrderFront(nil)
  }

  func applicationWillTerminate(_ aNotification: Notification) {
    // Insert code here to tear down your application
  }

  func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
    return true
  }


}

