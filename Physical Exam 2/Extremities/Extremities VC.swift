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
	@IBOutlet weak var limbAssessmentView: NSView!
	@IBOutlet weak var limbAssessmentTextView: NSTextView!
	@IBOutlet weak var bunionView: NSStackView!
	@IBOutlet weak var callusView: NSStackView!
	@IBOutlet weak var limbView: NSView!
	@IBOutlet weak var limbSideView: NSStackView!
	@IBOutlet weak var limbDecAbView: NSStackView!
	
	var digitAssessment = DigitAssessment()
	
	override func viewDidLoad() {
        super.viewDidLoad()
        clearExtremitiesTab()
    }
	
	@IBAction func clearExtremitiesTab(_ sender: Any) {
		clearExtremitiesTab()
	}
	
	@IBAction func processExtremitiesTab(_ sender: Any) {
		var resultArray = [String]()
		resultArray.append(edemaTextView.string)
		resultArray.append(pulsesTextView.string)
	resultArray.append(CapillaryRefill().processSectionFrom(getActiveButtonInfoIn(view: self.view)))
		resultArray.append(Bunions().processSectionFrom(getActiveButtonInfoIn(view: bunionView)))
		resultArray.append(Callus().processSectionFrom(getActiveButtonInfoIn(view: callusView)))
		resultArray.append(digitAssessmentTextView.string)
		resultArray.append(limbAssessmentTextView.string)
		let results = resultArray.filter {$0 != ""}.joined(separator: "\n")
		results.copyToPasteboard()
		print(results)
	}
	
	func clearExtremitiesTab() {
		self.view.clearControllers()
		self.view.populateSelectionsInViewUsing(Extremities())
		digitAssessment = DigitAssessment()
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
		case 1000: edemaTextView.addToViewsExistingText(Edema().processSectionFrom(getActiveButtonInfoIn(view: edemaView)))
		case 1001: pulsesTextView.addToViewsExistingText(Pulses().processSectionFrom(getActiveButtonInfoIn(view: pulsesView)))
		case 1002: digitAssessmentTextView.string = (digitAssessment.processSectionFrom(getActiveButtonInfoIn(view: digitAssessmentView)))
		case 1003: limbAssessmentTextView.addToViewsExistingText(Extremities().processSectionFrom(getActiveButtonInfoIn(view: limbAssessmentView)))
		default: return
		}
		sender.superview?.clearControllers()
		sender.superview?.populateSelectionsInViewUsing(Extremities())
	}
	
	@IBAction func setPropertiesOfRelatedButtons(_ sender:NSButton) {
		setPropertiesOfButtonsBasedOnTag(sender.tag)
	}
	
	func setPropertiesOfButtonsBasedOnTag(_ tag:Int) {
		
		func makeLimbsExclusive() {
			for subview in limbView.subviews {
				if let button = subview as? NSButton {
					button.action = #selector(selectOnlyOne(_:))
					button.state = .off
				}
			}
		}
		func makeLimbsNonexclusive() {
			for subview in limbView.subviews {
				if let button = subview as? NSButton {
					button.action = nil
					button.state = .off
				}
			}
		}
		switch tag {
		case 80:
			makeLimbsExclusive()
			limbDecAbView.makeButtonsInViewActive()
		case 81:
			makeLimbsExclusive()
			limbDecAbView.makeButtonsInViewInactive()
		case 82, 83:
			makeLimbsNonexclusive()
			limbDecAbView.makeButtonsInViewInactive()
		default: return
		}
	}

}
