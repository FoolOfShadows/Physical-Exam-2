//
//  Breast VC.swift
//  Physical Exam 2
//
//  Created by Fool on 1/10/18.
//  Copyright © 2018 Fulgent Wake. All rights reserved.
//

import Cocoa

class Breast_VC: NSViewController {

	
	override func viewDidLoad() {
        super.viewDidLoad()
        clearBreast()
    }
	
	@IBAction func processBreastTab(_ sender: Any) {
		var resultArray = [String]()
		resultArray.append(Breast().processSectionFrom(getActiveButtonInfoIn(view: self.view)))
		let results = resultArray.filter {$0 != ""}.joined(separator: "\n")
		results.copyToPasteboard()
		print(results)
	}
	
	
	@IBAction func clearBreastTab(_ sender: Any) {
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
				return [Int](1...5)
			default:
				return [Int]()
			}
		}
		
		guard let view = sender.superview else { return }
		guard let name = (view.superview as? NSBox)?.title else { return }
		turnButtons(getButtonsInView(sender.superview!), InRange: normalButtonRangesForSection(name.lowercased()), ToState: sender.state)
	}
    
}
