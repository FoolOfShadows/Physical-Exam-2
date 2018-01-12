//
//  Extremeties VC.swift
//  Physical Exam 2
//
//  Created by Fool on 1/9/18.
//  Copyright © 2018 Fulgent Wake. All rights reserved.
//

import Cocoa

class Extremities_VC: NSViewController {

	@IBOutlet weak var edemaView: NSView!
	@IBOutlet var edemaTextView: NSTextView!
	@IBOutlet weak var pulsesView: NSView!
	@IBOutlet var pulsesTextView: NSTextView!
	@IBOutlet weak var digitAssessmentView: NSView!
	@IBOutlet var digitAssessmentTextView: NSTextView!
	
	override func viewDidLoad() {
        super.viewDidLoad()
        clearExtremitiesTab()
    }
	
	@IBAction func clearExtremitiesTab(_ sender: Any) {
		clearExtremitiesTab()
	}
	
	@IBAction func processExtremitiesTab(_ sender: Any) {
		var resultArray = [String]()
		
		let results = resultArray.filter {$0 != ""}.joined(separator: "\n")
		print(results)
	}
	
	func clearExtremitiesTab() {
		self.view.clearControllers()
		self.view.populateSelectionsInViewUsing(Extremities())
	}
	
	@IBAction func selectOnlyOne(_ sender: NSButton) {
		if let buttons = sender.superview?.subviews as? [NSButton] {
			for button in buttons {
				if button.title != sender.title {
					button.state = .off
				}
			}
		}
	}
	
	@IBAction func selectNorms(_ sender: NSButton) {
		func normalButtonRangesForSection(_ section:String) -> [Int] {
			switch section {
			case "n:":
				return [Int](1...7)
			case "l:":
				return [Int](1...5)
			case "r:":
				return [Int](1...5)
			default:
				return [Int]()
			}
		}
		
		let name = sender.title
		turnButtons(getButtonsInView(sender.superview!), InRange: normalButtonRangesForSection(name.lowercased()), ToState: sender.state)
	}
	
	@IBAction func processSectionsToTextViews(_ sender: NSButton) {
		switch sender.tag {
		case 1000: edemaTextView.addToViewsExistingText(Extremities().processSectionFrom(getActiveButtonInfoIn(view: edemaView)))
		case 1001: pulsesTextView.addToViewsExistingText(Extremities().processSectionFrom(getActiveButtonInfoIn(view: pulsesView)))
		case 1002:
			digitAssessmentTextView.addToViewsExistingText(Extremities().processSectionFrom(getActiveButtonInfoIn(view: digitAssessmentView)))
		default: return
		}
		sender.superview?.clearControllers()
		sender.superview?.populateSelectionsInViewUsing(Extremities())
	}
	
}
