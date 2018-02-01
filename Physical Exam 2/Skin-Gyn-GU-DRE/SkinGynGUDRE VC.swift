//
//  SkinGynGUDRE VC.swift
//  Physical Exam 2
//
//  Created by Fool on 1/10/18.
//  Copyright © 2018 Fulgent Wake. All rights reserved.
//

import Cocoa

class SkinGynGUDRE_VC: NSViewController, ProcessTabProtocol {
	

	@IBOutlet weak var skinBox: NSBox!
	@IBOutlet weak var guBox: NSBox!
	@IBOutlet weak var gynBox: NSBox!
	@IBOutlet weak var dreBox: NSBox!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		loadedViewControllers.append(self)
        clearSkin()
    }
	
	@IBAction func processSkinTab(_ sender: Any) {
		let results = processTab()
		results.copyToPasteboard()
		print(results)
	}
	
	func processTab() -> String {
		var resultArray = [String]()
		
		resultArray.append(Skin().processSectionFrom(getActiveButtonInfoIn(view: skinBox)))
		resultArray.append(Gyn().processSectionFrom(getActiveButtonInfoIn(view: gynBox)))
		resultArray.append(GU().processSectionFrom(getActiveButtonInfoIn(view: guBox)))
		resultArray.append(DRE().processSectionFrom(getActiveButtonInfoIn(view: dreBox)))
		return resultArray.filter {$0 != ""}.joined(separator: "\n")
	}
	
	@IBAction func clearTab(_ sender: Any) {
		clearSkin()
	}
	
	func clearSkin() {
		self.view.clearControllers()
		gynBox.populateSelectionsInViewUsing(Gyn())
	}
	
	@IBAction func selectNorms(_ sender: NSButton) {
		func normalButtonRangesForSection(_ section:String) -> [Int] {
			switch section {
			case "skin", "gyn", "gu":
				return [Int](1...5)
			case "dre":
				return [Int](1...4)
			default:
				return [Int]()
			}
		}
		
		guard let view = sender.superview else { return }
		guard let name = (view.superview as? NSBox)?.title else { return }
		turnButtons(getButtonsInView(sender.superview!), InRange: normalButtonRangesForSection(name.lowercased()), ToState: sender.state)
	}
    
}
