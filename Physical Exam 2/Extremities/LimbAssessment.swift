//
//  LimbAssessment.swift
//  Physical Exam 2
//
//  Created by Fool on 1/18/18.
//  Copyright © 2018 Fulgent Wake. All rights reserved.
//

import Foundation
class LimbAssessment {
	
//	var vibSenseResults
//	var monofilamentResults
//	var spiderVeinResults
//	var vericoseResults
	
	func processSectionFrom(_ data: [(Int, String?)]) -> String {
		var results = String()
		var resultArray = [String]()
		var sectionHeading = String()
		var appendage = String()
		var side = String()
		var sense = String()
		
		for item in data {
			switch item.0 {
			case 80...83: sectionHeading = item.1!
			case 84...90: appendage = item.1!.lowercased()
			case 91: appendage = "abdomen"
			case 92...94: side = item.1!.lowercased()
			case 95, 96: sense = item.1!.lowercased()
			default: continue
			}
		}
		
		
		if !resultArray.isEmpty {
			results = resultArray.joined(separator: "\n")
		}
		
		return results
	}
}
