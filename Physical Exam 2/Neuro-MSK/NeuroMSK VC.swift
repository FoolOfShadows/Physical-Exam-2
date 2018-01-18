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
	
	@IBOutlet weak var mskResultsTextView: NSTextField!
	override func viewDidLoad() {
        super.viewDidLoad()
		clearMSKTab()
    }
    
	@IBAction func setMSKSelections(_ sender: NSPopUpButton) {
		switch sender.title {
		case "Head & Spine":
			mskSelectionsPopup.clearPopUpButton(menuItems: MSK().headSelections)
		case "Shoulders & Arms":
			mskSelectionsPopup.clearPopUpButton(menuItems: MSK().shoulderSelections)
		case "Hands":
			mskSelectionsPopup.clearPopUpButton(menuItems: MSK().handSelections)
		case "Hips & Legs":
			mskSelectionsPopup.clearPopUpButton(menuItems: MSK().hipSelections)
		case "Feet":
			mskSelectionsPopup.clearPopUpButton(menuItems: MSK().feetSelections)
		default:
			mskSelectionsPopup.clearPopUpButton(menuItems: ["Selected area not recognized"])
		}
		setMSKSidesAndROM(mskSelectionsPopup)
	}
	
	@IBAction func setMSKSidesAndROM(_ sender: NSPopUpButton) {
		let sidesRLB = {self.mskSidesPopup.clearPopUpButton(menuItems: MSK().sides);
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
			mskRangeDirectionPopup.clearPopUpButton(menuItems: MSK().theRomDirListGen)
		case "neck":
			mskRangeDirectionPopup.clearPopUpButton(menuItems: MSK().neckROMDirList)
			mskSidesPopup.isEnabled = false
		case "paraspinal":
			mskStrengthPopup.isEnabled = false
			mskRangeDirectionPopup.isEnabled = false
			mskRangeDegreesPopup.isEnabled = false
			mskTonePopup.isEnabled = false
		case "L-spine":
			mskRangeDirectionPopup.clearPopUpButton(menuItems: MSK().lspineROMDirList)
			sidesRLB()
		case "sacral":
			mskSidesPopup.isEnabled = false
			mskStrengthPopup.isEnabled = false
			mskRangeDirectionPopup.isEnabled = false
			mskRangeDegreesPopup.isEnabled = false
			mskTonePopup.isEnabled = false
		case "shoulder":
			mskRangeDirectionPopup.clearPopUpButton(menuItems: MSK().shoulderROMDirList)
			sidesRLB()
		case "elbow":
			mskRangeDirectionPopup.clearPopUpButton(menuItems: MSK().elbowROMDirList)
			sidesRLB()
		case "forearm":
			mskRangeDirectionPopup.clearPopUpButton(menuItems: MSK().forearmROMDirList)
			sidesRLB()
		case "wrist":
			mskRangeDirectionPopup.clearPopUpButton(menuItems: MSK().wristROMDirList)
			sidesRLB()
		case "hip":
			mskRangeDirectionPopup.clearPopUpButton(menuItems: MSK().hipROMDirList)
			sidesRLB()
		case "knee":
			mskRangeDirectionPopup.clearPopUpButton(menuItems: MSK().kneeROMDirList)
			sidesRLB()
		case "ankle":
			mskRangeDirectionPopup.clearPopUpButton(menuItems: MSK().ankleROMDirList)
			sidesRLB()
		case "foot":
			mskRangeDirectionPopup.clearPopUpButton(menuItems: MSK().footROMDirList)
			sidesRLB()
		case "heel":
			mskStrengthPopup.isEnabled = false
			mskRangeDirectionPopup.isEnabled = false
			mskRangeDegreesPopup.isEnabled = false
			mskTonePopup.isEnabled = false
		default:
			mskRangeDirectionPopup.clearPopUpButton(menuItems: MSK().theRomDirListGen)
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
	
	@IBAction func processNeuroMSKTab(_ sender: Any) {
		var resultArray = [String]()
		resultArray.append(Neuro().processSectionFrom(getActiveButtonInfoIn(view: neuroBox)))
		resultArray.append(MSK().processSectionFrom(getActiveButtonInfoIn(view: mskBox)))
		
		let results = resultArray.filter {$0 != ""}.joined(separator: "\n")
		results.copyToPasteboard()
		print(results)
	}
	
	func clearMSKTab() {
		self.view.clearControllers()
		mskAreaPopup.clearPopUpButton(menuItems: MSK().generalAreas)
		setMSKSelections(mskAreaPopup)
		setMSKSidesAndROM(mskSelectionsPopup)
		mskSwellingPopup.clearPopUpButton(menuItems: MSK().theSwlLocListGen)
		mskStrengthPopup.clearPopUpButton(menuItems: MSK().theStrengthList)
		mskRangeDegreesPopup.clearPopUpButton(menuItems: MSK().theRomList)
		mskTonePopup.clearPopUpButton(menuItems: MSK().theToneList)
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
	
}
