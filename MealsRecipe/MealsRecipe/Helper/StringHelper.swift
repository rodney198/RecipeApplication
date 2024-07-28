//
//  StringAttribute.swift
//  MealsRecipe
//
//  Created by Rodney Pinto on 26/07/24.
//

import Foundation
import UIKit

class StringHelper {
    
    static let shared = StringHelper()
    
    //Function to create Attributed Text
    func createAttributedString(fullText: String) -> NSMutableAttributedString {
        // Create an NSMutableAttributedString with the full text
        let attributedString = NSMutableAttributedString(string: fullText)
        
        // Define the text color for "View More"
        let viewMoreText = "View More"
        let viewMoreTextColor = UIColor.blue // Set your desired color
        
        // Find the range of "View More" in the full text
        if let viewMoreRange = fullText.range(of: viewMoreText) {
            let nsViewMoreRange = NSRange(viewMoreRange, in: fullText)
            
            // Add attributes to the "View More" text
            attributedString.addAttribute(.foregroundColor, value: viewMoreTextColor, range: nsViewMoreRange)
        }
        return attributedString
    }

    
}
