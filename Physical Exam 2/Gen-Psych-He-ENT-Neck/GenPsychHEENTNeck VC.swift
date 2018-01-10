//
//  GenPsychHEENTNeck VC.swift
//  Physical Exam 2
//
//  Created by Fool on 1/5/18.
//  Copyright © 2018 Fulgent Wake. All rights reserved.
//

import Cocoa

class GenPsychHEENTNeck_VC: NSViewController {

	@IBOutlet var genTabView: NSView!
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
		
		resultArray.append(Neck().processSectionFrom(getActiveButtonInfoIn(view: neckBox)))
		
		let results = resultArray.filter {$0 != ""}.joined(separator: "\n")
		print(results)
	}
	
	
	@IBAction func clearGenTab(_ sender: Any) {
		clearGen()
	}
	
	func clearGen() {
		genTabView.clearControllers()
	}
	
	@IBAction func selectNorms(_ sender: NSButton) {
		func normalButtonRangesForSection(_ section:String) -> [Int] {
			switch section {
			case "gen", "psy":
				return [Int](1...4)
			case "head/eye", "ent":
				return [Int](1...5)
			case "neck":
				return [Int](1...6)
			default:
				return [Int]()
			}
		}
		
		guard let view = sender.superview else { return }
		guard let name = (view.superview as? NSBox)?.title else { return }
		turnButtons(getButtonsInView(sender.superview!), InRange: normalButtonRangesForSection(name.lowercased()), ToState: sender.state)
	}

}


