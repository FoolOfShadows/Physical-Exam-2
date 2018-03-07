//
//  StringExtensions.swift
//  PTVN to PF 2
//
//  Created by Fool on 1/10/17.
//  Copyright © 2017 Fulgent Wake. All rights reserved.
//

import Cocoa

extension String {
	func findRegexMatchFrom(_ start: String, to end:String) -> String? {
		if self.contains(start) && self.contains(end) {
			guard let startRegex = try? NSRegularExpression(pattern: start, options: []) else { return nil }
			guard let endRegex = try? NSRegularExpression(pattern: end, options: []) else {return nil }
			let startMatch = startRegex.matches(in: self, options: [], range: NSRange(location: 0, length: self.count))
			let endMatch = endRegex.matches(in: self, options: [], range: NSRange(location: 0, length: self.count))
			
			let startRange = startMatch[0].range
			let endRange = endMatch[0].range
			
			let r = self.index(self.startIndex, offsetBy: startRange.location) ..< self.index(self.startIndex, offsetBy: endRange.location + endRange.length)
			
			return String(self[r])
		} else {
			return ""
		}
	}
	
	
	func findRegexMatchBetween(_ start: String, and end: String) -> String? {
		let startStripped = start.removeRegexCharactersFromString()
		let endStripped = end.removeRegexCharactersFromString()
		if self.contains(startStripped) && self.contains(endStripped) {
			//print("Starting text: \(start), Ending text: \(end)")
			guard let startRegex = try? NSRegularExpression(pattern: start, options: []) else { return nil }
			guard let endRegex = try? NSRegularExpression(pattern: end, options: []) else {return nil }
			
			let startMatch = startRegex.matches(in: self, options: [], range: NSRange(location: 0, length: self.count))
			let endMatch = endRegex.matches(in: self, options: [], range: NSRange(location: 0, length: self.count))
			
			let startRange = startMatch[0].range
			let endRange = endMatch[0].range
			
			//print("Start range is \(startRange.location), and the end range is \(endRange.location)")
			
			if startRange.location > endRange.location {
				return "Range for this section is out of bounds"
			} else {
			let r = self.index(self.startIndex, offsetBy: startRange.location + startRange.length) ..< self.index(self.startIndex, offsetBy: endRange.location)
			
			return String(self[r])
			}
		} else {
			return ""
		}
		
	}
    
    //A basic regular expression search function
    func simpleRegExMatch(_ theExpression: String) -> String {
        var theResult = ""
        let regEx = try! NSRegularExpression(pattern: theExpression, options: [])
        let length = self.count
        
        if let match = regEx.firstMatch(in: self, options: [], range: NSRange(location: 0, length: length)) {
            theResult = (self as NSString).substring(with: match.range)
        }
        return theResult
    }
	
	
	func removeWhiteSpace() -> String {
		return self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
	}
    
    //Clean extraneous text from the sections
    func cleanTheTextOf(_ badBits:[String]) -> String {
        var cleanedText = self.removeWhiteSpace()
        for theBit in badBits {
            cleanedText = cleanedText.replacingOccurrences(of: theBit, with: "")
        }
        cleanedText = cleanedText.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return cleanedText
    }
	
	func removeRegexCharactersFromString() -> String {
		let regexCharacters:Set<Character> = Set("\\*")
		return String(self.filter({ !regexCharacters.contains($0) }))
	}
	
	func prependSectionHeader(_ header:String) -> String {
		if !self.isEmpty {
			return "\(header):\n\(self)"
		}
		return self
	}
	
	func prependLineHeader(_ header:String) -> String {
		if !self.isEmpty {
			return "\(header):  \(self)"
		}
		return self
	}
	
	func copyToPasteboard() {
		let myPasteboard = NSPasteboard.general
		myPasteboard.clearContents()
		myPasteboard.setString(self, forType: NSPasteboard.PasteboardType.string)
	}
}

//extension NSView {
//	func clearControllers() {
//		func clearChecksTextfields(theView: NSView) {
//			for item in theView.subviews {
//				switch item {
//				case is NSButton: let checkbox = item as? NSButton
//				checkbox?.state = .off
//				case is NSTextField: let textfield = item as? NSTextField
//				if (textfield?.isEditable)!{
//					textfield?.stringValue = ""
//					}
//				case is NSTextView: let textview = item as? NSTextView
//				if (textview?.isEditable)! {
//					textview?.string = ""
//					}
//				case is NSTabView: let tabView = item as? NSTabView
//				for tabItem in (tabView?.tabViewItems)! {
//					clearChecksTextfields(theView: tabItem.view!)
//					}
//				case is NSView: clearChecksTextfields(theView: item)
//    default: continue
//				}
//			}
//		}
//		clearChecksTextfields(theView: self)
//	}
//}

