//
//  GlobalControlls VC.swift
//  Physical Exam 2
//
//  Created by Fool on 2/1/18.
//  Copyright © 2018 Fulgent Wake. All rights reserved.
//

import Cocoa

var loadedViewControllers = [NSViewController]()

class GlobalControlls_VC: NSViewController, NSSpeechRecognizerDelegate {

    let recognizer = NSSpeechRecognizer()!
    
    var commands = [
        //Extremities
        "callus right", "callus left", "callus bilateral",
        "Hi there", "Good morning", "Hello"
    ]
    let extremitiesCommands = ["callus right", "callus left", "callus bilateral"]
    
    let nc = NotificationCenter.default
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recognizer.commands = commands
        recognizer.delegate = self
    }
    
    override func viewDidAppear() {
        recognizer.startListening()
    }
    
	@IBAction func processAll(_ sender: Any) {
		var outputArray = [String]()
		for vc in loadedViewControllers {
			if let vc = vc as? ProcessTabProtocol {
				outputArray.append(vc.processTab())
			}
		}
		//print(loadedViewControllers)
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
        nc.post(name: Notification.Name("SetAllToNorm"), object: nil)
	}
	
    @IBAction func toggleListening(_ sender: NSButton) {
        switch sender.state {
        case .on:
            //GlobalControlls_VC.recognizer.startListening()
            print("I'm listening")
            sender.title = "Listening On"
        default:
            //GlobalControlls_VC.recognizer.stopListening()
            print("I don't care what you say anymore")
            sender.title = "Listening Off"
        }
    }
    
    func speechRecognizer(_ sender: NSSpeechRecognizer, didRecognizeCommand command: String) {
        print("I heard you say \(command)")
        nc.post(name: Notification.Name(command), object: extremitiesCommands)
    }
    
    override func viewWillDisappear() {
        recognizer.stopListening()
    }
}

