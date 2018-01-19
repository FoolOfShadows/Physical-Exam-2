//
//  MSKAssessmentViewController.swift
//  Physical Exam 2
//
//  Created by Fool on 12/21/17.
//  Copyright © 2017 Fulgent Wake. All rights reserved.
//

import Cocoa

class NeuroMSK_VC: NSViewController {

	@IBOutlet weak var neuroBox: NSBox!
	@IBOutlet weak var mskBox: NSBox!
	
	@IBOutlet weak var mskAreaPopup: NSPopUpButton!
	@IBOutlet weak var mskSelectionsPopup: NSPopUpButton!
	@IBOutlet weak var mskSidesPopup: NSPopUpButton!
	@IBOutlet weak var mskTTPCheckbox: NSButton!
	@IBOutlet weak var mskSwellingPopup: NSPopUpButton!
	@IBOutlet weak var mskStrengthPopup: NSPopUpButton!
	@IBOutlet weak var mskRangeDirectionPopup: NSPopUpButton!
	@IBOutlet weak var mskRangeDegreesPopup: NSPopUpButton!
	@IBOutlet weak var mskTonePopup: NSPopUpButton!
	
	let mskAssessmentSection = MSK()
	
	@IBOutlet weak var mskResultsTextView: NSTextView!
	override func viewDidLoad() {
        super.viewDidLoad()
		clearMSKTab()
    }
    
	@IBAction func setMSKSelections(_ sender: NSPopUpButton) {
		switch sender.title {
		case "Head & Spine":
			mskSelectionsPopup.clearPopUpButton(menuItems: mskAssessmentSection.headSelections)
		case "Shoulders & Arms":
			mskSelectionsPopup.clearPopUpButton(menuItems: mskAssessmentSection.shoulderSelections)
		case "Hands":
			mskSelectionsPopup.clearPopUpButton(menuItems: mskAssessmentSection.handSelections)
		case "Hips & Legs":
			mskSelectionsPopup.clearPopUpButton(menuItems: mskAssessmentSection.hipSelections)
		case "Feet":
			mskSelectionsPopup.clearPopUpButton(menuItems: mskAssessmentSection.feetSelections)
		default:
			mskSelectionsPopup.clearPopUpButton(menuItems: ["Selected area not recognized"])
		}
		setMSKSidesAndROM(mskSelectionsPopup)
	}
	
	@IBAction func setMSKSidesAndROM(_ sender: NSPopUpButton) {
		let sidesRLB = {self.mskSidesPopup.clearPopUpButton(menuItems: self.mskAssessmentSection.sides);
			self.mskSidesPopup.isEnabled = true;
			self.mskStrengthPopup.isEnabled = true;
			self.mskRangeDirectionPopup.isEnabled = true;
			self.mskRangeDegreesPopup.isEnabled = true;
			self.mskTonePopup.isEnabled = true
		}
		
		switch sender.title {
		case "head":
			mskSidesPopup.isEnabled = false
			mskTonePopup.isEnabled = false
			mskRangeDirectionPopup.clearPopUpButton(menuItems: mskAssessmentSection.theRomDirListGen)
		case "neck":
			mskRangeDirectionPopup.clearPopUpButton(menuItems: mskAssessmentSection.neckROMDirList)
			mskSidesPopup.isEnabled = false
		case "paraspinal":
			mskStrengthPopup.isEnabled = false
			mskRangeDirectionPopup.isEnabled = false
			mskRangeDegreesPopup.isEnabled = false
			mskTonePopup.isEnabled = false
		case "L-spine":
			mskRangeDirectionPopup.clearPopUpButton(menuItems: mskAssessmentSection.lspineROMDirList)
			sidesRLB()
		case "sacral":
			mskSidesPopup.isEnabled = false
			mskStrengthPopup.isEnabled = false
			mskRangeDirectionPopup.isEnabled = false
			mskRangeDegreesPopup.isEnabled = false
			mskTonePopup.isEnabled = false
		case "shoulder":
			mskRangeDirectionPopup.clearPopUpButton(menuItems: mskAssessmentSection.shoulderROMDirList)
			sidesRLB()
		case "elbow":
			mskRangeDirectionPopup.clearPopUpButton(menuItems: mskAssessmentSection.elbowROMDirList)
			sidesRLB()
		case "forearm":
			mskRangeDirectionPopup.clearPopUpButton(menuItems: mskAssessmentSection.forearmROMDirList)
			sidesRLB()
		case "wrist":
			mskRangeDirectionPopup.clearPopUpButton(menuItems: mskAssessmentSection.wristROMDirList)
			sidesRLB()
		case "hip":
			mskRangeDirectionPopup.clearPopUpButton(menuItems: mskAssessmentSection.hipROMDirList)
			sidesRLB()
		case "knee":
			mskRangeDirectionPopup.clearPopUpButton(menuItems: mskAssessmentSection.kneeROMDirList)
			sidesRLB()
		case "ankle":
			mskRangeDirectionPopup.clearPopUpButton(menuItems: mskAssessmentSection.ankleROMDirList)
			sidesRLB()
		case "foot":
			mskRangeDirectionPopup.clearPopUpButton(menuItems: mskAssessmentSection.footROMDirList)
			sidesRLB()
		case "heel":
			mskStrengthPopup.isEnabled = false
			mskRangeDirectionPopup.isEnabled = false
			mskRangeDegreesPopup.isEnabled = false
			mskTonePopup.isEnabled = false
		default:
			mskRangeDirectionPopup.clearPopUpButton(menuItems: mskAssessmentSection.theRomDirListGen)
			sidesRLB()
		}
		
	}
	
	
	
	@IBAction func addSelectionToResults(_ sender: Any) {
		var resultArray = [String]()
		
		guard var site = mskSelectionsPopup.titleOfSelectedItem?.capitalized else {return}
		if mskSidesPopup.isEnabled && mskSidesPopup.title != "" {
			site += " \(mskSidesPopup.title)"
		}
		
		if mskTTPCheckbox.state == .on {
			resultArray.append("tender")
		}
		
		if mskSwellingPopup.isEnabled && mskSwellingPopup.title != "" {
			resultArray.append("\(mskSwellingPopup.title) swelling")
		}
		
		if mskStrengthPopup.isEnabled && mskStrengthPopup.title != "" {
			resultArray.append("\(mskStrengthPopup.title) /5 strength")
		}
		
		if mskRangeDirectionPopup.isEnabled && mskRangeDirectionPopup.title != "" {
			var rom = "range of motion: \(mskRangeDirectionPopup.title)"
			if mskRangeDegreesPopup.isEnabled && mskRangeDegreesPopup.title != "" {
				rom += " \(mskRangeDegreesPopup.title) degrees"
			}
			resultArray.append(rom)
		}
		
		if mskTonePopup.isEnabled && mskTonePopup.title != "" {
			resultArray.append("tone \(mskTonePopup.title)")
		}
		
		
		var existingAssessment = mskResultsTextView.string
		if !existingAssessment.isEmpty {
			existingAssessment = existingAssessment + "\n"
		}
		
		mskResultsTextView.string = "\(existingAssessment)\(site): \(resultArray.joined(separator: ", "))."
	}
	
	@IBAction func clearMSKAssessmentTab(_ sender: Any) {
		clearMSKTab()
	}
	
	@IBAction func processNeuroMSKTab(_ sender: Any) {
		
		mskAssessmentSection.mskAbnormalResults = mskResultsTextView.string
		var resultArray = [String]()
		resultArray.append(Neuro().processSectionFrom(getActiveButtonInfoIn(view: neuroBox)))
		resultArray.append(mskAssessmentSection.processSectionFrom(getActiveButtonInfoIn(view: mskBox)))
		
		let results = resultArray.filter {$0 != ""}.joined(separator: "\n")
		results.copyToPasteboard()
		print(results)
	}
	
	func clearMSKTab() {
		self.view.clearControllers()
		mskAreaPopup.clearPopUpButton(menuItems: mskAssessmentSection.generalAreas)
		setMSKSelections(mskAreaPopup)
		setMSKSidesAndROM(mskSelectionsPopup)
		mskSwellingPopup.clearPopUpButton(menuItems: mskAssessmentSection.theSwlLocListGen)
		mskStrengthPopup.clearPopUpButton(menuItems: mskAssessmentSection.theStrengthList)
		mskRangeDegreesPopup.clearPopUpButton(menuItems: mskAssessmentSection.theRomList)
		mskTonePopup.clearPopUpButton(menuItems: mskAssessmentSection.theToneList)
		neuroBox.populateSelectionsInViewUsing(Neuro())
	}
	
	@IBAction func selectNorms(_ sender: NSButton) {
		func normalButtonRangesForSection(_ section:String) -> [Int] {
			switch section {
			case "neuro":
				return [Int](1...6)
			case "msk":
				return [Int](1...4)
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
	}
}
