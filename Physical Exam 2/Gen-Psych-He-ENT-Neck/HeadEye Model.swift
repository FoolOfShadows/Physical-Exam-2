//
//  HeadEye Model.swift
//  Physical Exam 2
//
//  Created by Fool on 1/8/18.
//  Copyright © 2018 Fulgent Wake. All rights reserved.
//

import Foundation
struct HeadEye {
	func processSectionFrom(_ data: [(Int, String?)]) -> String {
		var results = String()
		var resultArray = [String]()
		
		for item in data {
			switch item.0 {
			case 1: resultArray.append("hd normocephalic atraumatic, no lesions")
			case 2: resultArray.append("pupils equal round, reactive to light and accomodation")
			case 3: resultArray.append("extraocular muscles intact")
			case 4: resultArray.append("no icterus")
			case 5: resultArray.append("conjunctivae clear")
			case 6: resultArray.append("le sclera red")
			case 7: resultArray.append("le muddy")
			case 8: resultArray.append("le icteric")
			case 9: resultArray.append("le arcus sinilus")
			case 10: resultArray.append("le esotropia")
			case 11: resultArray.append("re sclera red")
			case 12: resultArray.append("re muddy")
			case 13: resultArray.append("re icteric")
			case 14: resultArray.append("re arcus sinilus")
			case 15: resultArray.append("re esotropia")
			case 20: resultArray.append("hd \(item.1!)")
			case 21: resultArray.append(item.1!)
			default: continue
			}
		}
		
		let leftEye = resultArray.filter {$0.contains("le ")}
		let rightEye = resultArray.filter {$0.contains("re ")}
		
		let headArray = resultArray.filter {$0.contains("hd ")}
		var eyeArray = resultArray.filter {!$0.contains("le ") && !$0.contains("re ") && !$0.contains("hd ")}
		
		if !rightEye.isEmpty {
			eyeArray.insert("Right eye: " + (rightEye.joined(separator: ", ")).replacingOccurrences(of: "re ", with: ""), at:0)
		}
		if !leftEye.isEmpty {
			eyeArray.insert("Left eye: " + (leftEye.joined(separator: ", ")).replacingOccurrences(of: "le ", with: ""), at:0)
		}
		
		if !headArray.isEmpty {
			resultArray.append("HEAD: \(headArray.joined(separator: ", ").replacingOccurrences(of: "hd ", with: ""))")
		}
		if !eyeArray.isEmpty {
			resultArray.append("EYE: \(eyeArray.joined(separator: ", "))")
		}
		
		
		
		
		
		if !resultArray.isEmpty {
			results = resultArray.joined(separator: "\n")
		}
		
		return results
	}
}
