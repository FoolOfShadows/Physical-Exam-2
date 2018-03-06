//
//  Breast VC.swift
//  Physical Exam 2
//
//  Created by Fool on 1/10/18.
//  Copyright © 2018 Fulgent Wake. All rights reserved.
//

import Cocoa

class Breast_VC: NSViewController, ProcessTabProtocol {
	var selfView = NSView()
	

	
	override func viewDidLoad() {
        super.viewDidLoad()
		loadedViewControllers.append(self)
		selfView = self.view
        clearBreast()
    }
	
	@IBAction func processBreastTab(_ sender: Any) {
		let results = processTab()
		results.copyToPasteboard()
		//print(results)
	}
	
	func processTab() -> String {
		var resultArray = [String]()
		resultArray.append(Breast().processSectionFrom(getActiveButtonInfoIn(view: self.view)))
		return resultArray.filter {$0 != ""}.joined(separator: "\n")
	}
	
	@IBAction func clearTab(_ sender: Any) {
		clearBreast()
	}
	
	func clearBreast() {
		self.view.clearControllers()
		self.view.populateSelectionsInViewUsing(Breast())
	}
	
	@IBAction func selectNorms(_ sender: NSButton) {
		func normalButtonRangesForSection(_ section:String) -> [Int] {
			switch section {
			case "breast":
				return [Int](1...4)
			default:
				return [Int]()
			}
		}
		
		guard let view = sender.superview else { return }
		turnButtons(getButtonsInView(view), InRange: normalButtonRangesForSection("breast"), ToState: sender.state)
	}
    
}
