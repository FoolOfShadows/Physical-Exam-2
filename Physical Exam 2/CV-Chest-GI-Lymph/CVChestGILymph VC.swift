//
//  CVChestGILymph VC.swift
//  Physical Exam 2
//
//  Created by Fool on 1/8/18.
//  Copyright © 2018 Fulgent Wake. All rights reserved.
//

import Cocoa

class CVChestGILymph_VC: NSViewController, NSTextFieldDelegate, ProcessTabProtocol {
	var selfView = NSView()
	

	@IBOutlet weak var cvBox: NSBox!
	@IBOutlet weak var chestBox: NSBox!
	@IBOutlet weak var giBox: NSBox!
	@IBOutlet weak var lymphBox: NSBox!
	@IBOutlet weak var giTTPCombo: NSComboBox!
	@IBOutlet var giTTPView: NSTextField!
	@IBOutlet weak var giMassCombo: NSComboBox!
	@IBOutlet var giMassView: NSTextField!
    @IBOutlet weak var cracklesCombo: NSComboBox!
    
    @IBOutlet weak var wheezingCombo: NSComboBox!
    
    
    //let commands = ["wheezing rule", "wheezing lull", "wheezing bull", "wheezing armel", "wheezing ell"]
	
	override func viewDidLoad() {
        super.viewDidLoad()
		loadedViewControllers.append(self)
		selfView = self.view
        
        giTTPView.delegate = self
        giMassView.delegate = self
        
        clearCV()
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(selectAllNormsInView), name: NSNotification.Name(rawValue: "SetAllToNorm"), object: nil)
        
//        GlobalControlls_VC.recognizer.delegate = self
//        GlobalControlls_VC.recognizer.commands = commands
    }
	
	
	@IBAction func processCVTab(_ sender: Any) {
		let results = processTab()
		results.copyToPasteboard()
		//print(results)
	}
	
	func processTab() -> String {
		var resultArray = [String]()
		resultArray.append(Cardiovascular().processSectionFrom(getActiveButtonInfoIn(view: cvBox)))
		resultArray.append(Chest().processSectionFrom(getActiveButtonInfoIn(view: chestBox)))
		resultArray.append(GI().processSectionFrom(getActiveButtonInfoIn(view: giBox)))
		resultArray.append(Lymph().processSectionFrom(getActiveButtonInfoIn(view: lymphBox)))
		return resultArray.filter {$0 != ""}.joined(separator: "\n")
		
	}
	
	
	@IBAction func clearTab(_ sender: Any) {
		clearCV()
	}
	
	func clearCV() {
		self.view.clearControllers()
		cvBox.populateSelectionsInViewUsing(Cardiovascular())
		chestBox.populateSelectionsInViewUsing(Chest())
		giBox.populateSelectionsInViewUsing(GI())
	}
	
	@IBAction func selectNorms(_ sender: NSButton) {
		func normalButtonRangesForSection(_ section:String) -> [Int] {
			switch section {
			case "lymph":
				return [Int](1...4)
			case "chest":
				return [Int](1...8)
			case "cv", "gi":
				return [Int](1...7)
			default:
				return [Int]()
			}
		}
		
		guard let view = sender.superview else { return }
		guard let name = (view.superview as? NSBox)?.title else { return }
		turnButtons(getButtonsInView(sender.superview!), InRange: normalButtonRangesForSection(name.lowercased()), ToState: sender.state)
	}
	
	@IBAction func selectOnlyOne(_ sender: NSButton) {
		if let buttons = sender.superview?.subviews as? [NSButton] {
			for button in buttons {
				if button.title != sender.title {
					button.state = .off
				}
			}
		}
        switchNormOff(sender)
	}
    
    fileprivate func textSwitchNormOff() {
        if !giTTPView.stringValue.isEmpty {
            let theButtons = giBox.getButtonsInView()
            theButtons.filter({$0.tag == 2})[0].state = .off
        }
        if !giMassView.stringValue.isEmpty {
            let theButtons = giBox.getButtonsInView()
            theButtons.filter({$0.tag == 6})[0].state = .off
        }
    }
    
    override func controlTextDidChange(_ obj: Notification) {
        print("text change message sent")
        textSwitchNormOff()
    }
    
    @IBAction func switchNormOff(_ sender: NSButton) {
        if sender.state == .on {
            
            let sendingBox = (sender as NSView).getContainingBox()
            guard let sendingBoxTitle = sendingBox?.title else { return }
            print(sendingBoxTitle)
            guard let theButtons = sendingBox?.getButtonsInView() else { return }
            
            switch sendingBoxTitle {
            case "CV":
                switch sender.tag {
                case 9...12:
                    theButtons.filter({$0.tag == 1})[0].state = .off
                case 13, 14:
                    theButtons.filter({$0.tag == 3})[0].state = .off
                case 21:
                    theButtons.filter({$0.tag == 2})[0].state = .off
                default: return
                }
            case "Chest":
                switch sender.tag {
                case 100:
                    theButtons.filter({$0.tag == 1})[0].state = .off
                default: return
                }
            case "GI":
                switch sender.tag {
                case 30...32:
                    theButtons.filter({$0.tag == 7})[0].state = .off
                case 8:
                    theButtons.filter({$0.tag == 4})[0].state = .off
                default: return
                }
            case "Lymph":
                switch sender.tag {
                case 10...12:
                    theButtons.filter({$0.tag == 2})[0].state = .off
                case 13...15:
                    theButtons.filter({$0.tag == 3})[0].state = .off
                case 16...18:
                    theButtons.filter({$0.tag == 4})[0].state = .off
                case 19...27:
                    theButtons.filter({$0.tag == 1})[0].state = .off
                default: return
                }
            default: return
            }
        }
        
    }
    
    @IBAction func comboSwitchNormOff(_ sender: NSComboBox) {
        if !sender.stringValue.isEmpty {
            
            let sendingBox = (sender as NSView).getContainingBox()
            guard let sendingBoxTitle = sendingBox?.title else { return }
            print(sendingBoxTitle)
            guard let theButtons = sendingBox?.getButtonsInView() else { return }
            
            switch sendingBoxTitle {
            case "CV":
                switch sender.tag {
                case 20, 22:
                    theButtons.filter ({$0.tag == 2})[0].state = .off
                default: return
                }
            case "Chest":
                switch sender.tag {
                case 10:
                    theButtons.filter ({$0.tag == 3})[0].state = .off
                    theButtons.filter ({$0.tag == 2})[0].state = .off
                case 11:
                    theButtons.filter ({$0.tag == 4})[0].state = .off
                    theButtons.filter ({$0.tag == 2})[0].state = .off
                case 12:
                    theButtons.filter ({$0.tag == 5})[0].state = .off
                    theButtons.filter ({$0.tag == 2})[0].state = .off
                case 13:
                    theButtons.filter ({$0.tag == 7})[0].state = .off
                    theButtons.filter ({$0.tag == 2})[0].state = .off
                default: return
                }
            default: return
            }
            
        }
        
    }
	
	@IBAction func giTakeTTP(_ sender: NSComboBox) {
		let currentView = giTTPView.stringValue
		if sender.stringValue != "" {
			if currentView != "" {
				giTTPView.stringValue = "\(currentView), \(sender.stringValue)"
			} else {
				giTTPView.stringValue = sender.stringValue
			}
			sender.selectItem(at: 0)
            textSwitchNormOff()
		}
	}
	
	@IBAction func giTakeMass(_ sender: NSComboBox) {
		let currentView = giMassView.stringValue
		if sender.stringValue != "" {
			if currentView != "" {
				giMassView.stringValue = "\(currentView), \(sender.stringValue)"
			} else {
				giMassView.stringValue = sender.stringValue
			}
			sender.selectItem(at: 0)
            textSwitchNormOff()
		}
	}
    
    @objc func selectAllNormsInView() {
        //Don't turn on lymph norms
        var normButtons = cvBox.getNormalButtonsInView()
        normButtons += chestBox.getNormalButtonsInView()
        normButtons += giBox.getNormalButtonsInView()
        for button in normButtons {
            button.state = .on
            selectNorms(button)
        }
    }
    
//    func speechRecognizer(_ sender: NSSpeechRecognizer, didRecognizeCommand command: String) {
//        switch command {
//        case "wheezing rule": wheezingCombo.stringValue = "RUL"
//        case  "wheezing lull": wheezingCombo.stringValue = "LUL"
//        case "wheezing bull": wheezingCombo.stringValue = "BUL"
//        case "wheezing armel": wheezingCombo.stringValue = "RML"
//        case "wheezing ell": wheezingCombo.stringValue = "LLL"
//        //case "callus right": wheezingCombo.stringValue = "Callus Right"
//        default: return
//        }
//    }
}
