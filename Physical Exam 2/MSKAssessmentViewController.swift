//
//  MSKAssessmentViewController.swift
//  Physical Exam 2
//
//  Created by Fool on 12/21/17.
//  Copyright © 2017 Fulgent Wake. All rights reserved.
//

import Cocoa

class MSKAssessmentViewController: NSViewController {

	@IBOutlet var mskAssessmentView: NSView!
	
	@IBOutlet weak var mskAreaPopup: NSPopUpButton!
	@IBOutlet weak var mskSelectionsPopup: NSPopUpButton!
	@IBOutlet weak var mskSidesPopup: NSPopUpButton!
	@IBOutlet weak var mskTTPCheckbox: NSButton!
	@IBOutlet weak var mskSwellingPopup: NSPopUpButton!
	@IBOutlet weak var mskStrengthPopup: NSPopUpButton!
	@IBOutlet weak var mskRangeDirectionPopup: NSPopUpButton!
	@IBOutlet weak var mskRangeDegreesPopup: NSPopUpButton!
	@IBOutlet weak var mskTonePopup: NSPopUpButton!
	
	@IBOutlet weak var mskResultsTextView: NSTextField!
	override func viewDidLoad() {
        super.viewDidLoad()
		clearMSKTab()
    }
    
	@IBAction func setMSKSelections(_ sender: NSPopUpButton) {
		switch sender.title {
		case "Head & Spine":
			mskSelectionsPopup.clearPopUpButton(menuItems: MSKAssessment().headSelections)
		case "Shoulders & Arms":
			mskSelectionsPopup.clearPopUpButton(menuItems: MSKAssessment().shoulderSelections)
		case "Hands":
			mskSelectionsPopup.clearPopUpButton(menuItems: MSKAssessment().handSelections)
		case "Hips & Legs":
			mskSelectionsPopup.clearPopUpButton(menuItems: MSKAssessment().hipSelections)
		case "Feet":
			mskSelectionsPopup.clearPopUpButton(menuItems: MSKAssessment().feetSelections)
		default:
			mskSelectionsPopup.clearPopUpButton(menuItems: ["Selected area not recognized"])
		}
		setMSKSidesAndROM(mskSelectionsPopup)
	}
	
	@IBAction func setMSKSidesAndROM(_ sender: NSPopUpButton) {
		let sidesRLB = {self.mskSidesPopup.clearPopUpButton(menuItems: MSKAssessment().sides);
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
			mskRangeDirectionPopup.clearPopUpButton(menuItems: MSKAssessment().theRomDirListGen)
		case "neck":
			mskRangeDirectionPopup.clearPopUpButton(menuItems: MSKAssessment().neckROMDirList)
			mskSidesPopup.isEnabled = false
		case "paraspinal":
			mskStrengthPopup.isEnabled = false
			mskRangeDirectionPopup.isEnabled = false
			mskRangeDegreesPopup.isEnabled = false
			mskTonePopup.isEnabled = false
		case "L-spine":
			mskRangeDirectionPopup.clearPopUpButton(menuItems: MSKAssessment().lspineROMDirList)
			sidesRLB()
		case "sacral":
			mskSidesPopup.isEnabled = false
			mskStrengthPopup.isEnabled = false
			mskRangeDirectionPopup.isEnabled = false
			mskRangeDegreesPopup.isEnabled = false
			mskTonePopup.isEnabled = false
		case "shoulder":
			mskRangeDirectionPopup.clearPopUpButton(menuItems: MSKAssessment().shoulderROMDirList)
			sidesRLB()
		case "elbow":
			mskRangeDirectionPopup.clearPopUpButton(menuItems: MSKAssessment().elbowROMDirList)
			sidesRLB()
		case "forearm":
			mskRangeDirectionPopup.clearPopUpButton(menuItems: MSKAssessment().forearmROMDirList)
			sidesRLB()
		case "wrist":
			mskRangeDirectionPopup.clearPopUpButton(menuItems: MSKAssessment().wristROMDirList)
			sidesRLB()
		case "hip":
			mskRangeDirectionPopup.clearPopUpButton(menuItems: MSKAssessment().hipROMDirList)
			sidesRLB()
		case "knee":
			mskRangeDirectionPopup.clearPopUpButton(menuItems: MSKAssessment().kneeROMDirList)
			sidesRLB()
		case "ankle":
			mskRangeDirectionPopup.clearPopUpButton(menuItems: MSKAssessment().ankleROMDirList)
			sidesRLB()
		case "foot":
			mskRangeDirectionPopup.clearPopUpButton(menuItems: MSKAssessment().footROMDirList)
			sidesRLB()
		case "heel":
			mskStrengthPopup.isEnabled = false
			mskRangeDirectionPopup.isEnabled = false
			mskRangeDegreesPopup.isEnabled = false
			mskTonePopup.isEnabled = false
		default:
			mskRangeDirectionPopup.clearPopUpButton(menuItems: MSKAssessment().theRomDirListGen)
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
		
		
		var existingAssessment = mskResultsTextView.stringValue
		if !existingAssessment.isEmpty {
			existingAssessment = existingAssessment + "\n"
		}
		
		mskResultsTextView.stringValue = "\(existingAssessment)\(site): \(resultArray.joined(separator: ", "))."
	}
	
	@IBAction func clearMSKAssessmentTab(_ sender: Any) {
		clearMSKTab()
	}
	
	@IBAction func processMSKAssessmentTab(_ sender: Any) {
		mskResultsTextView.stringValue.copyToPasteboard()
	}
	
	func clearMSKTab() {
		mskAssessmentView.clearControllers()
		mskAreaPopup.clearPopUpButton(menuItems: MSKAssessment().generalAreas)
		setMSKSelections(mskAreaPopup)
		setMSKSidesAndROM(mskSelectionsPopup)
		mskSwellingPopup.clearPopUpButton(menuItems: MSKAssessment().theSwlLocListGen)
		mskStrengthPopup.clearPopUpButton(menuItems: MSKAssessment().theStrengthList)
		mskRangeDegreesPopup.clearPopUpButton(menuItems: MSKAssessment().theRomList)
		mskTonePopup.clearPopUpButton(menuItems: MSKAssessment().theToneList)
	}
	
}
