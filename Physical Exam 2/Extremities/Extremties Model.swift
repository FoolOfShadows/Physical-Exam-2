//
//  Extremeties Model.swift
//  Physical Exam 2
//
//  Created by Fool on 1/10/18.
//  Copyright © 2018 Fulgent Wake. All rights reserved.
//

import Foundation
struct Extremities:PopulateComboBoxProtocol {
	let cbRLBList = ["", "right", "left", "bilateral"]
	let cbPitting = ["", "pitting", "slight pitting", "non-pitting"]
	let cbPulses = ["", "+2 pulses", "+1 pulses", "diminished pulses", "absent pulses"]
	let puEdemaQuant = ["", "trace", "+1", "+2", "+3", "+4"]
	let cbEdema = ["", "toes", "foot", "ankle", "calf", "knee", "thigh", "hip", "groin", "gluteal", "hand", "wrist", "forearm", "elbow", "upper arm", "shoulder"]
	let cbPulsesLocation = ["", "dorsalis pedis", "posterior tibial", "popliteal", "femoral", "radial", "ulnar", "brachial"]
	
	func matchValuesFrom(_ id: Int) -> [String]? {
		switch id {
		case 40: return puEdemaQuant
		case 41: return cbPitting
		case 42: return cbRLBList
		case 43: return cbEdema
		case 50, 52: return cbPulses
		case 51, 53: return cbPulsesLocation
		default: return ["No matching values found."]
		}
	}
	
	func processSectionFrom(_ data: [(Int, String?)]) -> String {
		var results = String()
		var resultArray = [String]()
		var edemaString = String()
		var lPulseString = String()
		var rPulseString = String()
		
		for item in data {
			switch item.0 {
			case 40: edemaString += "\(item.1!) "
			case 41: edemaString += "\(item.1!) "
			case 42: edemaString += "of \(item.1!) "
			case 43: edemaString += item.1!
			case 44: resultArray.append("brawny")
			case 45: resultArray.append("lymphedema")
			case 46: resultArray.append("venus insufficiency")
			case 47: resultArray.append("cellulitis")
			case 50: lPulseString += "\(item.1!) "
			case 51: lPulseString += "left \(item.1!)"
			case 52: rPulseString += "\(item.1!) "
			case 53: rPulseString += "right \(item.1!)"
			case 54: resultArray.append("Oncomyosis:")
			case 55: resultArray.append("Cyanosis:")
			case 56: resultArray.append("Hammer toe(s) on:")
			case 57: resultArray.append("toe(s)")
			case 58: resultArray.append("finger(s)")
			case 59: resultArray.append("")
			case 60: resultArray.append("")
			case 61: resultArray.append("")
			case 62: resultArray.append("")
			case 63: resultArray.append("")
			case 64: resultArray.append("")
			case 65: resultArray.append("")
			case 66: resultArray.append("")
			case 67: resultArray.append("")
			case 68: resultArray.append("")
			case 69: resultArray.append("")
			default: continue
			}
		}
		if !edemaString.isEmpty {
			resultArray.insert(edemaString, at: 0)
		}
		
		if !lPulseString.isEmpty {
			resultArray.append(lPulseString)
		}
		if !rPulseString.isEmpty {
			resultArray.append(rPulseString)
		}
		
		
		if !resultArray.isEmpty {
			results = resultArray.joined(separator: ", ")
		}
		
		return results
	}
}
