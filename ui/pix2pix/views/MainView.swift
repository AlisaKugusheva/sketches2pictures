//
//  MainView.swift
//  pix2pix
//
//  Created by Rita Konnova on 13.12.2021.
//

import Cocoa
import PythonKit

class MainView: NSView {
  
  private enum Mode {
    case catsAndDogs
    case cars
  }
  
  private lazy var drawView = DrawView()
  private lazy var resultImageView = NSImageView()
  private lazy var clearButton = ToolButton()
  private lazy var processSketchButton = ToolButton()
  private lazy var updateButton = ToolButton()
  private lazy var switchButton = ToolButton()
  private var modelWasDownloaded = false
  private var mode: Mode = .cars {
    didSet {
      switch mode {
      case .cars:
        switchButton.title = "Switch to Cats & Dogs"
      case .catsAndDogs:
        switchButton.title = "Switch to Cars"
      }
      
      setNeedsDisplay(self.frame)
    }
  }

  // Put your path here
  private let MAIN_PATH = "/Users/riri/Desktop/sketches2pictures/ui"
  
  override init(frame frameRect: NSRect) {
    super.init(frame: frameRect)
    self.addSubview(drawView)
    self.addSubview(resultImageView)
    self.addSubview(clearButton)
    self.addSubview(processSketchButton)
//    self.addSubview(updateButton)
    self.addSubview(switchButton)
    
    self.switchButton.title = "Switch to Cats & Dogs"
    self.resultImageView.imageScaling = .scaleProportionallyUpOrDown
    
    self.clearButton.clickHandler = { [weak self] in
      guard let self = self else { return }
      self.drawView.clear()
      self.resultImageView.image = nil
      self.setNeedsDisplay(self.frame)
    }
    
    // You don't need to change this part
    let PATH_TO_SCRIPTS = MAIN_PATH + "/scripts"
    let PATH_TO_CHECKPOINTS = "'\(MAIN_PATH)/checkpoints'" // model weights
    let PATH_TO_SOURCE_DATA = "'\(MAIN_PATH)'"
    let PATH_TO_RESULTS = "'\(MAIN_PATH)/results'"
    let PATH_WITH_FINAL_IMAGES = MAIN_PATH + "/results/" + (self.mode == .cars ? "edges2cars" : "edges2pets") + "/test_latest/images/sketch_fake_B.png"
    
    self.processSketchButton.clickHandler = { [weak self] in
      guard let self = self else { return }
      
      // Clear the folder with the screenshots
      print(shell("rm -R \(self.MAIN_PATH + "/test")"))
      print(shell("mkdir \(self.MAIN_PATH + "/test")"))
      
      self.takeScreenshotWithSketch()
      
      if !self.modelWasDownloaded {
        self.modelWasDownloaded = true
        // This needs to be run once to install the required libs
        // print(shell("python3 -m pip install -r \(PATH_TO_SCRIPTS)/requirements.txt"))
        // print(shell("bash \(PATH_TO_SCRIPTS)/scripts/download_pix2pix_model.sh edges2shoes"))
      }
      // Clear the folder with the results
      print(shell("rm -R \(PATH_TO_RESULTS)"))
      print(shell("mkdir \(PATH_TO_RESULTS)"))
      
      // Call the pretrained model
      switch self.mode {
      case .cars:
        print(shell("python3 \(PATH_TO_SCRIPTS)/test.py --dataroot \(PATH_TO_SOURCE_DATA) --model pix2pix --name edges2cars --checkpoints_dir \(PATH_TO_CHECKPOINTS) --results_dir \(PATH_TO_RESULTS) --gpu_ids -1 --direction BtoA"))
      case .catsAndDogs:
        print(shell("python3 \(PATH_TO_SCRIPTS)/test.py --dataroot \(PATH_TO_SOURCE_DATA) --model pix2pix --name edges2pets --checkpoints_dir \(PATH_TO_CHECKPOINTS) --results_dir \(PATH_TO_RESULTS) --gpu_ids -1 --direction BtoA"))
      }
      
      self.resultImageView.image = NSImage(contentsOf: URL(fileURLWithPath: PATH_WITH_FINAL_IMAGES))
      self.setNeedsDisplay(self.frame)
    }
    
    self.switchButton.clickHandler = { [weak self] in
      guard let self = self else { return }
      self.mode = self.mode == .catsAndDogs ? .cars : .catsAndDogs
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func takeScreenshotWithSketch() {
    self.clearButton.alphaValue = 0
    self.processSketchButton.alphaValue = 0
    self.updateButton.alphaValue = 0
    
    self.setNeedsDisplay(self.frame)
    
    takeScreenshots(folderName: "\(MAIN_PATH)/test/")
    
    self.clearButton.alphaValue = 1
    self.processSketchButton.alphaValue = 1
    self.updateButton.alphaValue = 1
    
    self.setNeedsDisplay(self.frame)
  }
  
  override func draw(_ dirtyRect: NSRect) {
    super.draw(dirtyRect)
    let buttonHeight = CGFloat(42)
    resultImageView.frame = CGRect(x: 16,
                            y: 16,
                            width: frame.width / 2 - 32,
                            height: frame.height - 32 - buttonHeight - 32)
    
    drawView.frame = CGRect(x: resultImageView.frame.maxX + 16,
                            y: 16,
                            width: resultImageView.frame.width,
                            height: resultImageView.frame.height)
    
    clearButton.frame = CGRect(x: 16,
                               y: frame.maxY - 16.0 - buttonHeight,
                               width: 81,
                               height: buttonHeight)
    
    processSketchButton.frame = CGRect(x: clearButton.frame.maxX + 16,
                                       y: frame.maxY - 16.0 - buttonHeight,
                                       width: 81,
                                       height: buttonHeight)
    updateButton.frame = CGRect(x: processSketchButton.frame.maxX + 16,
                                y: frame.maxY - 16.0 - buttonHeight,
                                width: 81,
                                height: buttonHeight)
    switchButton.frame = CGRect(x: self.frame.maxX - 180.0 - 16.0,
                                y: frame.maxY - 16.0 - buttonHeight,
                                width: 180,
                                height: buttonHeight)
    
    layer?.backgroundColor = NSColor.white.cgColor
    resultImageView.layer?.backgroundColor = NSColor.white.cgColor
    clearButton.layer?.backgroundColor = NSColor.blue.cgColor
    updateButton.layer?.backgroundColor = NSColor.blue.cgColor
    processSketchButton.layer?.backgroundColor = NSColor.blue.cgColor
    
    clearButton.title = "Clear"
    processSketchButton.title = "Process"
    updateButton.title = "Update"
  }
  
}
