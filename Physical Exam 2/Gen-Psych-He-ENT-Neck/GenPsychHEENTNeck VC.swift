//
//  GenPsychHEENTNeck VC.swift
//  Physical Exam 2
//
//  Created by Fool on 1/5/18.
//  Copyright © 2018 Fulgent Wake. All rights reserved.
//

import Cocoa

class GenPsychHEENTNeck_VC: NSViewController {

	@IBOutlet weak var genBox: NSBox!
	@IBOutlet weak var psychBox: NSBox!
	@IBOutlet weak var headEyeBox: NSBox!
	@IBOutlet weak var entBox: NSBox!
	@IBOutlet weak var neckBox: NSBox!
	
	override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
	
	@IBAction func processGenTab(_ sender: Any) {
		var resultArray = [String]()
		
		resultArray.append(General().processSectionFrom(getActiveButtonInfoIn(view: genBox)))
		resultArray.append(Psychological().processSectionFrom(getActiveButtonInfoIn(view: psychBox)))
		resultArray.append(HeadEye().processSectionFrom(getActiveButtonInfoIn(view: headEyeBox)))
		resultArray.append(ENT().processSectionFrom(getActiveButtonInfoIn(view: entBox)))
		resultArray.append(Neck().processSectionFrom(getActiveButtonInfoIn(view: neckBox)))
		
		let results = resultArray.filter {$0 != ""}.joined(separator: "\n")
		print(results)
		results.copyToPasteboard()
	}
	
	
	@IBAction func clearGenTab(_ sender: Any) {
		clearGen()
	}
	
	func clearGen() {
		self.view.clearControllers()
	}
	
	@IBAction func selectNorms(_ sender: NSButton) {
		func normalButtonRangesForSection(_ section:String) -> [Int] {
			switch section {
			case "gen", "psy":
				return [Int](1...4)
			case "head/eye":
				return [Int](1...5)
			case "neck":
				return [Int](1...6)
			case "ent":
				return [1,2,40,41,20]
			default:
				return [Int]()
			}
		}
		
		guard let view = sender.superview else { return }
		guard let name = (view.superview as? NSBox)?.title else { return }
		turnButtons(getButtonsInView(sender.superview!), InRange: normalButtonRangesForSection(name.lowercased()), ToState: sender.state)
	}


}


