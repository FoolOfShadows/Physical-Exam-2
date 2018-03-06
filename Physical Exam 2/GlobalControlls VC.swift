//
//  GlobalControlls VC.swift
//  Physical Exam 2
//
//  Created by Fool on 2/1/18.
//  Copyright © 2018 Fulgent Wake. All rights reserved.
//

import Cocoa

var loadedViewControllers = [NSViewController]()

class GlobalControlls_VC: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
	@IBAction func processAll(_ sender: Any) {
		var outputArray = [String]()
		for vc in loadedViewControllers {
			if let vc = vc as? ProcessTabProtocol {
				outputArray.append(vc.processTab())
			}
		}
		print(loadedViewControllers)
		let results = outputArray.filter {!$0.isEmpty}
		results.joined(separator: "\n").copyToPasteboard()
	}
	
	@IBAction func clearAll(_ sender: Any) {
		for vc in loadedViewControllers {
			if let vc = vc as? ProcessTabProtocol {
				vc.clearTab(self)
			}
		}
	}
	
	@IBAction func setAllToNorm(_ sender: NSButton) {
		for vc in loadedViewControllers {
			if let vcMeetsProtocol = vc as? ProcessTabProtocol {
				
			}
		}
	}
	
}


