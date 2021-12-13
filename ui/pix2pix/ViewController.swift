//
//  ViewController.swift
//  pix2pix
//
//  Created by Rita Konnova on 13.12.2021.
//

import Cocoa

class ViewController: NSViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

  }

  override var representedObject: Any? {
    didSet {
    // Update the view, if already loaded.
    }
  }
  
  override func loadView() {
    self.view = MainView(frame: NSRect(x: 0, y: 0, width: 1100, height: 500))
  }


}

