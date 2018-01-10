//
//  Breast Model.swift
//  Physical Exam 2
//
//  Created by Fool on 1/10/18.
//  Copyright © 2018 Fulgent Wake. All rights reserved.
//

import Foundation
struct Breast:PopulateComboBoxProtocol {
	let cbDischargeList = ["", "yellow", "green", "bloody"]
	
	func matchValuesFrom(_ id: Int) -> [String]? {
		switch id {
		case 11: return cbDischargeList
		default: return ["No matching values found."]
		}
	}
	
	func processSectionFrom(_ data: [(Int, String?)]) -> String {
		var results = String()
		var resultArray = [String]()
		
		
		for item in data {
			switch item.0 {
			case 1: resultArray.append("no dominant masses")
			case 2: resultArray.append("no nipple discharge")
			case 3: resultArray.append("no axillary lymphadenopathy present")
			case 4: resultArray.append("nontender")
			case 6: resultArray.append("diffuse fibrocystic densities")
			case 7: resultArray.append("axillary lymphadenopathy present")
			case 11: resultArray.append("diffuse fibrocystic densities")
			case 12: resultArray.append("axillary lymphadenopathy present")
			case 1001...1012: resultArray.append("tenderness at \(item.0%1000):00")
			case 1013: resultArray.append("tenderness around nipple")
			case 1113: resultArray.append("masses around nipple")
			case 2213: resultArray.append("cysts around nipple")
			case 3313: resultArray.append("fibrodensities around nipple")
			case 4001...4012: resultArray.append("tenderness at \(item.0%1000):00")
			case 4013: resultArray.append("tenderness around nipple")
			case 4413: resultArray.append("masses around nipple")
			case 5513: resultArray.append("cysts around nipple")
			case 6613: resultArray.append("fibrodensities around nipple")
			case 5: resultArray.append("\(item.1!)")
			case 1014: resultArray.append("\(item.1!) tenderness")
			case 1015: resultArray.append("galactorrhea: \(item.1!)")
			case 4013: resultArray.append("\(item.1!) tenderness")
			case 4014: resultArray.append("galactorrhea: \(item.1!)")
			default: continue
			}
		}
		
		if !resultArray.isEmpty {
			results = "BREAST: \(resultArray.joined(separator: ", "))"
		}
		
		return results
	}
}
