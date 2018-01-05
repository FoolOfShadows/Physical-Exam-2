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
	
	var genButtons:[NSButton] {return getButtonsInView(genTabView)}
	
	override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
	
	@IBAction func processGenTab(_ sender: Any) {
	}
	
	
	@IBAction func clearGenTab(_ sender: Any) {
		clearGen()
	}
	
	func clearGen() {
		genTabView.clearControllers()
	}
	
}
